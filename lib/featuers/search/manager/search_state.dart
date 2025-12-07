import 'package:stylish/featuers/home/data/models/product_model.dart';

abstract class SearchState{}
class SearchInital extends SearchState{}
class SearchLoading extends SearchState{}
class SearchSuccess extends SearchState{
  final ProductModel data;
  SearchSuccess({required this.data});

}
class SearchError extends SearchState{
  final String error;
  SearchError({required this.error});

}