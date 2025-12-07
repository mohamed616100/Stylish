import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/featuers/home/manager/product_cubit/product_states.dart';

import '../../data/repos/product_repo.dart';

class ProductCubit extends Cubit<ProductStates>{
  ProductCubit():super(ProductInitial());
  static ProductCubit get(context)=> BlocProvider.of(context);

  getProduct()async{
    ProductRepo productRepo =ProductRepo();
    emit(ProductLoading());
    var response= await productRepo.getsProduct();
    response.fold(
      (error)=> emit(ProductError(error: error)),
        (data)=> emit(ProductSuccess(data: data))
    );
  }

}