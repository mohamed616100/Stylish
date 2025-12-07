abstract class CartState {}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<dynamic> items;
  CartUpdated(this.items);
}
