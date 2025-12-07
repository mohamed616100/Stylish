import '../../data/models/categorie_model.dart';

abstract class CategorieStates {}

class CategorieInitial extends CategorieStates {}
class CategorieLoading extends CategorieStates {}
class CategorieSuccess extends CategorieStates {
  final CategorieModel data;
  CategorieSuccess({required this.data});
}
class CategorieError extends CategorieStates {
  final String message;
  CategorieError({required this.message});
}

class CategorieProductsLoading extends CategorieStates {}
class CategorieProductsSuccess extends CategorieStates {
  final List<dynamic> products;
  CategorieProductsSuccess({required this.products});
}
