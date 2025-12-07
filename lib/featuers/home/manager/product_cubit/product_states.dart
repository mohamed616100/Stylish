import '../../data/models/product_model.dart';

abstract class ProductStates{}
class ProductInitial extends ProductStates{}
class ProductLoading extends ProductStates{}
class ProductError extends ProductStates{
  final String error;
  ProductError({required this.error});
}
class ProductSuccess extends ProductStates{
  final ProductModel data;
  ProductSuccess({required this.data});
}