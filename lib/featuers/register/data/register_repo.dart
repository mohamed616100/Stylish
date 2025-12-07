import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylish/core/network/api_response.dart';
import '../../../core/network/api_helper.dart';
import '../../../core/network/app_endpoint.dart';
class RegisterRepo{
  ApiHelper apiHelper=ApiHelper();
  Future<Either<String, ApiResponse>> register({
    required String phone,
    required String name,
    required String email,
    required String password,
    XFile? image
  })async
  {
    try {
      final Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      };

      // If image exists, attach as file
      if (image != null) {
        data['image'] = await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        );
      }
      var response = await apiHelper.postRequest(
          endPoint: EndPoints.register,
          data: data
      );
      if(response.status)
      {
        return right(response);
      }
      else
      {
        return left(response.message);
      }
    }
    catch (e) {
      return Left(ApiResponse.fromError(e).message);

    }
  }
}