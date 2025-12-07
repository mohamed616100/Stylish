
import '../../data/model/order_model.dart';

enum OrdersTab { active, completed, canceled }

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersError extends OrdersState {
  final String message;
  OrdersError(this.message);
}

class OrdersSuccess extends OrdersState {
  final OrdersResponse data;
  final OrdersTab tab;

  OrdersSuccess({required this.data, required this.tab});
}

class OrdersTabChanged extends OrdersState {
  final OrdersResponse data;
  final OrdersTab tab;

  OrdersTabChanged({required this.data, required this.tab});
}

class CancelOrderLoading extends OrdersState {
  final OrdersResponse data;
  final OrdersTab tab;
  final int orderId;
  CancelOrderLoading({
    required this.data,
    required this.tab,
    required this.orderId,
  });
}

class CancelOrderSuccess extends OrdersState {
  final OrdersResponse data;
  final OrdersTab tab;
  final String message;
  CancelOrderSuccess({
    required this.data,
    required this.tab,
    required this.message,
  });
}

class CancelOrderError extends OrdersState {
  final OrdersResponse data;
  final OrdersTab tab;
  final String message;
  CancelOrderError({
    required this.data,
    required this.tab,
    required this.message,
  });
}
