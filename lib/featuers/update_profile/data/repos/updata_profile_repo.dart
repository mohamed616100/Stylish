import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/app_endpoint.dart';

class UpdateProfileRepo {
  final ApiHelper _apiHelper = ApiHelper();

  Future<Either<String, ApiResponse>> updateProfile({
    required String name,
    required String phone,
    XFile? image,
  }) async {
    try {
      final Map<String, dynamic> body = {
        "name": name,
        "phone": phone,
      };

      if (image != null) {
        body["image"] = await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        );
      }


      ApiResponse response = await _apiHelper.putRequest(
        endPoint: EndPoints.UpdateProfile,
        isProtected: true,
        isFormData: true,
        data: body,
      );

      if (response.status) {
        return Right(response);
      } else {
        return Left(response.message);
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ApiResponse.fromError(e).message);
      }
      return Left(e.toString());
    }
  }
}
