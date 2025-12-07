import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish/core/network/api_helper.dart';
import 'package:stylish/core/network/api_response.dart';
import 'package:stylish/core/network/app_endpoint.dart';
import 'package:stylish/featuers/login/data/model/login_response_model.dart';

class LoginRepo{
  ApiHelper apiHelper= ApiHelper();
  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await apiHelper.postRequest(
          endPoint: EndPoints.login,
          data: {
            'email': email,
            'password': password,
          }
      );
      if (response.status) {
        LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
            response.data);
        SharedPreferences sharedPreferences = await SharedPreferences
            .getInstance();
        sharedPreferences.setString(
            'access_token', loginResponseModel.accessToken!);
        sharedPreferences.setString(
            'refresh_token', loginResponseModel.refreshToken!);
        return Right(loginResponseModel.user!);
      } else {
        return Left(response.message);
      }
      } catch (e) {
      return Left(ApiResponse.fromError(e).message);
    }
  }
    }
