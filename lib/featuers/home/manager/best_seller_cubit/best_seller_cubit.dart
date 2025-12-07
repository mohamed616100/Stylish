import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/best_seller_repo.dart';
import 'best_seller_states.dart';
class BestSellerCubit extends Cubit<BestSellerState>{
  BestSellerCubit():super(BestSellerInitial());
  static BestSellerCubit get(context)=>BlocProvider.of(context);
  getBestSeller()async{
    BestSellerRepo bestSellerRepo = BestSellerRepo();
    emit(BestSellerLoading());
    var response =await bestSellerRepo.getBestSeller();
    response.fold((error) {
      emit(BestSellerError(error: error));
    }, (data) {
      emit(BestSellerSuccess(data: data));
    });
  }
}

