import 'package:dio/dio.dart';

class ApiResponse {
  final bool status;
  final int statusCode;
  final dynamic data;
  final String message;

  ApiResponse({
    required this.status,
    required this.statusCode,
    this.data,
    required this.message,
  });

  factory ApiResponse.fromResponse(Response response) {
    final body = response.data;
    bool status = false;
    String message = '';

    if (body is Map<String, dynamic>) {
      status = body['status'] == true;
      message = body['message']?.toString() ?? '';
    } else {
      status = (response.statusCode != null && response.statusCode! < 400);
      message = '';
    }

    return ApiResponse(
      status: status,
      statusCode: response.statusCode ?? 500,
      data: body,
      message: message,
    );
  }

  factory ApiResponse.fromError(dynamic error) {
    print(error.toString());

    if (error is DioException) {
      final res = error.response;
      final data = res?.data;
      final msg = _handleDioError(error);

      return ApiResponse(
        status: false,
        data: data,
        statusCode: res?.statusCode ?? 500,
        message: msg,
      );
    } else {
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'An error occurred.',
      );
    }
  }

  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout, please try again.";
      case DioExceptionType.sendTimeout:
        return "Send timeout, please check your internet.";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout, please try again later.";
      case DioExceptionType.badResponse:
        return _handleServerError(error.response);
      case DioExceptionType.cancel:
        return "Request was cancelled.";
      case DioExceptionType.connectionError:
        return "No internet connection.";
      default:
        return "Unknown error occurred.";
    }
  }

  static String _handleServerError(Response? response) {
    if (response == null) return "No response from server.";

    final data = response.data;

    if (data is Map<String, dynamic>) {
      if (data['message'] != null) {
        print("----- Handle Server Error ${data['message']}");
        return data['message'].toString();
      }
      return "An error occurred.";
    }

    return "Server error: ${response.statusMessage}";
  }
}
