import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../data/repos/categorie_repo.dart';
import 'categorie_states.dart';
import '../../../../core/network/api_response.dart';
import '../../../../featuers/items/data/models/categorie_model.dart';


class CategorieCubit extends Cubit<CategorieStates> {
 final CategorieRepo repo= CategorieRepo();
 CategorieCubit() : super(CategorieInitial());

 late CategorieModel categorieModel;
 List<dynamic> categories = [];
 List<dynamic> selectedProducts = [];
 int selectedIndex = 0;

 static CategorieCubit get(context) => BlocProvider.of(context);

 Future<void> getCategorie() async {
  try {
   emit(CategorieLoading());
   final Either<String, CategorieModel> res = await repo.getsProduct();

   res.fold((failure) {
    emit(CategorieError(message: failure));
   }, (model) {
    categorieModel = model;
    categories = (categorieModel.categories ?? []).cast<dynamic>();
    emit(CategorieSuccess(data: categorieModel));

    if (categories.isNotEmpty) {
     selectedIndex = 0;
     selectedProducts = (categories[0].products ?? []).cast<dynamic>();
     emit(CategorieProductsSuccess(products: selectedProducts));
    } else {
     selectedProducts = [];
     emit(CategorieProductsSuccess(products: selectedProducts));
    }
   });
  } catch (e) {
   final msg = ApiResponse.fromError(e).message;
   emit(CategorieError(message: msg));
  }
 }

 void selectCategoryByIndex(int index) {
  if (index < 0 || index >= categories.length) return;
  selectedIndex = index;
  emit(CategorieProductsLoading());
  selectedProducts = (categories[index].products ?? []).cast<dynamic>();
  emit(CategorieProductsSuccess(products: selectedProducts));
 }


}
