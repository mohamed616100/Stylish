import 'package:stylish/featuers/checkout/data/model/place_order_model.dart';

abstract class PlaceOrderState {}

class PlaceOrderInitial extends PlaceOrderState {}

class PlaceOrderLoading extends PlaceOrderState {}

class PlaceOrderSuccess extends PlaceOrderState {
  final PlaceOrderModel order;

  PlaceOrderSuccess(this.order);
}

class PlaceOrderError extends PlaceOrderState {
  final String message;

  PlaceOrderError(this.message);
}
