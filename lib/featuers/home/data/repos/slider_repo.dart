import 'package:dartz/dartz.dart';
import 'package:stylish/core/network/api_helper.dart';
import 'package:stylish/featuers/home/data/models/slider_model.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/network/app_endpoint.dart';
class SliderRepo{
  ApiHelper apiHelper =ApiHelper();
  Future<Either<String, SliderModel>> getslider() async
  {
    try
    {
      var response = await apiHelper.getRequest(
          endPoint: EndPoints.slider,
          isProtected: false,
          sendRefreshToken: false
      );
      if(response.status)
      {
        SliderModel slider= SliderModel.fromJson(response.data);
        return Right(slider);
      }
      else
      {
        return Left(response.message);
      }
    }
    catch(e)
    {
      return Left(ApiResponse.fromError(e).message);
    }
  }
}