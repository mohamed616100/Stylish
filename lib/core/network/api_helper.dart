import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_response.dart';
import 'app_endpoint.dart';

class ApiHelper {
  // singleton
  static final ApiHelper _instance = ApiHelper._init();
  factory ApiHelper() {
    _instance._initDio();
    return _instance;
  }
  ApiHelper._init();

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.ecoBaseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  bool _initialized = false;
  bool _isRefreshing = false;

  void _initDio() {
    if (_initialized) return;
    _initialized = true;

    dio.interceptors.clear();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print("--- Headers : ${options.headers}");
          print("--- endpoint : ${options.path}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("--- Response : ${response.data}");
          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          print("--- Error : ${error.response?.data}");

          final res = error.response;
          final data = res?.data;

          // مفيش response أصلاً → رجّع الـ error عادي
          if (res == null) {
            return handler.next(error);
          }

          // لو الـ error جاي من endPoint الـ refresh_token نفسه
          // متحاولش تعمل refresh تاني
          if (error.requestOptions.path == EndPoints.refreshToken) {
            await _logout();
            return handler.next(error);
          }

          String? message;
          if (data is Map<String, dynamic>) {
            message = data['message']?.toString();
          } else if (data is String) {
            message = data;
          }

          final statusCode = res.statusCode;
          final bool tokenExpired = _isTokenExpired(statusCode, message);

          // لو الـ error مش بسبب إن التوكن منتهي → رجّعه عادي
          if (!tokenExpired) {
            return handler.next(error);
          }

          // لو مفيش refresh_token متخزن أصلاً → مفيش حاجة نعملها غير logout
          final prefs = await SharedPreferences.getInstance();
          final storedRefreshToken = prefs.getString('refresh_token');
          if (storedRefreshToken == null || storedRefreshToken.isEmpty) {
            await _logout();
            return handler.next(error);
          }

          print(" Token expired — trying to refresh...");

          // لو فيه refresh شغال بالفعل متحاولش تعمل واحد جديد
          if (_isRefreshing) {
            return handler.next(error);
          }

          _isRefreshing = true;
          try {
            final ApiResponse apiResponse = await _instance.postRequest(
              endPoint: EndPoints.refreshToken,
              isProtected: true,
              sendRefreshToken: true, // هنا بيستخدم refresh_token فعلاً
              isFormData: false,
            );

            if (apiResponse.status) {
              print("Token refreshed successfully");

              final newAccessToken =
              apiResponse.data['access_token']?.toString();

              if (newAccessToken == null || newAccessToken.isEmpty) {
                await _logout();
                _isRefreshing = false;
                return handler.next(error);
              }

              await prefs.setString('access_token', newAccessToken);

              // إعادة إرسال نفس الطلب القديم بعد ما حدّثنا الـ access_token
              final RequestOptions options = error.requestOptions;

              if (options.data is FormData) {
                final oldFormData = options.data as FormData;

                final Map<String, dynamic> formMap = {};
                for (var entry in oldFormData.fields) {
                  formMap[entry.key] = entry.value;
                }
                for (var file in oldFormData.files) {
                  formMap[file.key] = file.value;
                }

                options.data = FormData.fromMap(formMap);
              }

              options.headers['Authorization'] = 'Bearer $newAccessToken';

              final Response retryResponse = await dio.fetch(options);
              _isRefreshing = false;
              return handler.resolve(retryResponse);
            } else {
              print(" Refresh failed — logging out");
              await _logout();
              _isRefreshing = false;
              return handler.next(error);
            }
          } catch (e) {
            print(" Refresh crashed — logging out");
            await _logout();
            _isRefreshing = false;
            return handler.next(error);
          }
        },
      ),
    );
  }

  /// دايمًا بترجع bool ومفيش ولا حالة بترجع null
  bool _isTokenExpired(int? statusCode, String? message) {
    // 401 من الـ API = unauthorized / token expired
    if (statusCode == 401) return true;

    // مفيش message أصلاً → اعتبرها مش بسبب التوكن
    if (message == null) return false;

    final msg = message.toLowerCase();

    // لو الـ API رجّع رسالة فيها الكلمات دي نعتبر إن التوكن انتهى
    if (msg.contains('only refresh tokens are allowed')) return true;
    if (msg.contains('refresh token')) return true;

    return msg.contains('expired') ||
        msg.contains('expire') ||
        msg.contains('token') ||
        msg.contains('unauthorized');
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

  // ------------ Requests ------------

  Future<ApiResponse> postRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isProtected = false,
    bool sendRefreshToken = false,
  }) async {
    String? token;
    if (isProtected) {
      final sharedPref = await SharedPreferences.getInstance();
      token = sharedPref.getString(
        sendRefreshToken ? 'refresh_token' : 'access_token',
      );
    }

    final Response response = await dio.post(
      endPoint,
      data: isFormData ? FormData.fromMap(data ?? {}) : data,
      options: Options(
        headers: {
          if (isProtected) 'Authorization': 'Bearer $token',
        },
      ),
    );

    return ApiResponse.fromResponse(response);
  }

  Future<ApiResponse> getRequest({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    bool isProtected = false,
    bool sendRefreshToken = false,
  }) async {
    String? token;
    if (isProtected) {
      final sharedPref = await SharedPreferences.getInstance();
      token = sharedPref.getString(
        sendRefreshToken ? 'refresh_token' : 'access_token',
      );
    }

    final Response response = await dio.get(
      endPoint,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          if (isProtected) 'Authorization': 'Bearer $token',
        },
      ),
    );

    return ApiResponse.fromResponse(response);
  }


  Future<ApiResponse> deleteRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isProtected = true,
  }) async {
    String? token;
    if (isProtected) {
      final sharedPref = await SharedPreferences.getInstance();
      token = sharedPref.getString('access_token');
    }

    final Response response = await dio.delete(
      endPoint,
      data: isFormData ? FormData.fromMap(data ?? {}) : data,
      options: Options(
        headers: {
          if (isProtected) 'Authorization': 'Bearer $token',
        },
      ),
    );

    return ApiResponse.fromResponse(response);
  }

  Future<ApiResponse> putRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = true,
    bool isProtected = false,
  }) async {
    String? token;
    if (isProtected) {
      final sharedPref = await SharedPreferences.getInstance();
      token = sharedPref.getString('access_token');
    }

    final Response response = await dio.put(
      endPoint,
      queryParameters: queryParameters,
      data: isFormData ? FormData.fromMap(data ?? {}) : data,
      options: Options(
        headers: {
          if (isProtected) 'Authorization': 'Bearer $token',
        },
      ),
    );

    return ApiResponse.fromResponse(response);
  }
}
