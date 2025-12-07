import 'package:dartz/dartz.dart';

import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/app_endpoint.dart';
import '../models/best_seller_model.dart';

class BestSellerRepo{
  ApiHelper apiHelper = ApiHelper();
  Future<Either<String, BestSellerModel>> getBestSeller() async
  {
    try
    {
      var response = await apiHelper.getRequest(
          endPoint: EndPoints.bestSeller,
          isProtected: true,
      );
      if(response.status)
      {
        BestSellerModel bestSeller= BestSellerModel.fromJson(response.data);
        return Right(bestSeller);
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