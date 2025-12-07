import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/order_model.dart';
import '../../data/repo/order_repo.dart';
import 'order_states.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this._repo) : super(OrdersInitial());

  static OrdersCubit get(context) => BlocProvider.of(context);

  final OrdersRepo _repo;

  OrdersResponse? _data;
  OrdersTab currentTab = OrdersTab.active;

  OrdersResponse get data => _data!;

  int? cancellingOrderId;

  Future<void> getOrders() async {
    emit(OrdersLoading());
    final result = await _repo.getOrders();
    result.fold(
          (error) => emit(OrdersError(error)),
          (orders) {
        _data = orders;
        currentTab = OrdersTab.active;
        emit(OrdersSuccess(data: orders, tab: currentTab));
      },
    );
  }

  void changeTab(OrdersTab tab) {
    if (_data == null) return;
    currentTab = tab;
    emit(OrdersTabChanged(data: _data!, tab: currentTab));
  }

  Future<void> cancelOrder(int orderId) async {
    if (_data == null) return;

    cancellingOrderId = orderId;
    emit(CancelOrderLoading(
      data: _data!,
      tab: currentTab,
      orderId: orderId,
    ));

    final result = await _repo.cancelOrder(orderId);

    result.fold(
          (error) {
        cancellingOrderId = null;
        emit(CancelOrderError(
          data: _data!,
          tab: currentTab,
          message: error,
        ));
      },
          (res) {
        final activeList = _data!.orders.active;
        final canceledList = _data!.orders.canceled;

        final index = activeList.indexWhere((o) => o.id == orderId);
        if (index != -1) {
          final order = activeList.removeAt(index);
          canceledList.insert(0, order);
        }

        cancellingOrderId = null;

        emit(CancelOrderSuccess(
          data: _data!,
          tab: currentTab,
          message: res.message ?? 'Order cancelled',
        ));
      },
    );
  }
}
