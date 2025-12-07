import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/featuers/home/data/models/product_model.dart';
import 'package:stylish/featuers/search/manager/search_state.dart';
import '../data/repo/search_repo.dart';
class SearchCubit extends Cubit<SearchState>{
  SearchCubit() : super(SearchInital());
  static SearchCubit get(context)=> BlocProvider.of(context);
  void getSearch({
    required String q,
  })async{
    SearchRepo searchRepo = SearchRepo();
    emit(SearchLoading());
    ProductModel _= ProductModel();
    var response = await searchRepo.getSearch(q: q);
    response.fold((error)=>emit(SearchError(error: error))
        ,(sucess)=>emit(SearchSuccess(data: sucess)));
  }

}