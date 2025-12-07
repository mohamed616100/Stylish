import 'package:dartz/dartz.dart';
import 'package:stylish/core/network/api_helper.dart';
import 'package:stylish/core/network/api_response.dart';
import 'package:stylish/core/network/app_endpoint.dart';
import 'package:stylish/featuers/home/data/models/product_model.dart';

class SearchRepo {
  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, ProductModel>> getSearch({
    required String q,
  }) async {
    try {
      final apiResponse = await apiHelper.getRequest(
        endPoint: EndPoints.search(q: q),
        isProtected: true,
      );
      if (apiResponse.statusCode == 200) {
        return Right(ProductModel.fromJson(apiResponse.data));
      } else {
        return Left(apiResponse.message);
      }
    } on Exception catch (e) {
      return Left(ApiResponse.fromError(e).message);
    }
  }
}