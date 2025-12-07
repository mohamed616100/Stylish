import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/featuers/checkout/data/repo/place_order_repo.dart';
import 'package:stylish/featuers/checkout/manager/place_order_cubit/place_order_state.dart';

import '../../../place_order/data/models/card_model.dart';


class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  PlaceOrderCubit() : super(PlaceOrderInitial());


  static PlaceOrderCubit get(context) => BlocProvider.of(context);

   final PlaceOrderRepo placeOrderRepo=PlaceOrderRepo();

  Future<void> placeOrderFromCart({
    required List<CartItem> cartItems,
    required String address,
  }) async {
    emit(PlaceOrderLoading());
    final itemsPayload = cartItems
        .map((e) => {
      "product_id": e.id,
      "quantity": e.quantity,
      "price": e.price,
    })
        .toList();

    final result = await placeOrderRepo.placeOrder(items: itemsPayload);

    result.fold(
          (error) => emit(PlaceOrderError(error)),
          (order) => emit(PlaceOrderSuccess(order)),
    );
  }
}
