import 'package:dartz/dartz.dart';
import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/app_endpoint.dart';
import '../model/cancel_model.dart';
import '../model/order_model.dart';

class OrdersRepo {
  final ApiHelper _apiHelper = ApiHelper();

  Future<Either<String, OrdersResponse>> getOrders() async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints.Order,
        isProtected: true,
      );

      if (response.status) {
        final data = OrdersResponse.fromJson(response.data);
        return Right(data);
      } else {
        return Left(response.message);
      }
    } catch (e) {
      return Left(ApiResponse.fromError(e).message);
    }
  }

  Future<Either<String, CanceldResopnse>> cancelOrder(int orderId) async {
    try {
      final response = await _apiHelper.postRequest(
        endPoint: EndPoints.CancelOrder(id: orderId),
        isProtected: true,
        isFormData: false,
      );

      if (response.status) {
        final data = CanceldResopnse.fromJson(response.data);
        return Right(data);
      } else {
        return Left(response.message);
      }
    } catch (e) {
      return Left(ApiResponse.fromError(e).message);
    }
  }
}
