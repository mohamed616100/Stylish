import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/featuers/home/manager/slider_cubit/slider_states.dart';

import '../../data/repos/slider_repo.dart';

class SliderCubit extends Cubit<SliderState>{
  SliderCubit():super(SliderInitial());
  int currentIndex = 0;
  final CarouselSliderController controller = CarouselSliderController();
  static SliderCubit get(context) => BlocProvider.of(context);
  getSlider()async{
      SliderRepo sliderRepo =SliderRepo();
    emit(SliderLoading());
    var response= await sliderRepo.getslider();
      response.fold((error) {
        emit(SliderError(error: error));
      }, (data) {
        emit(SliderSuccess(data: data));
      });
  }
  void onPageChanged(index,reason) {
    currentIndex = index;
  }

}