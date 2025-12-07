import 'package:dartz/dartz.dart';
import 'package:stylish/featuers/checkout/data/model/place_order_model.dart';

import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_response.dart' ;
import '../../../../core/network/app_endpoint.dart';

class PlaceOrderRepo {
  Future<Either<String, PlaceOrderModel>>placeOrder({
    required List<Map<String, dynamic>> items,
  }) async {
    try {
      ApiHelper apiHelper = ApiHelper();
      final response = await apiHelper.postRequest(
        endPoint: EndPoints.PlaceOrder,
        isFormData: false,
        isProtected: true,
        data: {
          "items": items,
        },
      );

      if (response.status) {
        final orderResponse = PlaceOrderModel.fromJson(
          response.data,
        );
        return Right(orderResponse);
      } else {
        return Left(response.message);
      }
    } catch (e) {
      return Left(ApiResponse.fromError(e).message);
    }
  }

}
