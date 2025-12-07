import 'package:dartz/dartz.dart';
import 'package:stylish/core/network/api_helper.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/app_endpoint.dart';
import '../models/product_model.dart';
class ProductRepo{
  ApiHelper apiHelper =ApiHelper();
  Future<Either<String, ProductModel>> getsProduct() async
  {
    try
    {
      var response = await apiHelper.getRequest(
          endPoint: EndPoints.products,
          isProtected: true,
      );
      if(response.status)
      {
        ProductModel product= ProductModel.fromJson(response.data);
        return Right(product);
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