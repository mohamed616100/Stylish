import 'package:dartz/dartz.dart';
import 'package:stylish/core/network/api_response.dart';

import '../../../../core/network/api_helper.dart';
import '../../../../core/network/app_endpoint.dart';
import '../../../login/data/model/login_response_model.dart';

class UserRepo{
  ApiHelper apiHelper = ApiHelper();
  Future<Either<String, UserModel>> getUser()async
  {
    try{
      var response = await apiHelper.getRequest(
          endPoint: EndPoints.getUserData,
          isProtected: true,
      );
      if(response.status)
      {
        var data = response.data as Map<String, dynamic>;
        LoginResponseModel responseModel =
        LoginResponseModel.fromJson(data);
        return right(responseModel.user!);
      }
      else{
        return Left(response.message);
      }
    }
    catch(e)
    {
      return Left(ApiResponse.fromError(e).message);
    }
  }
}