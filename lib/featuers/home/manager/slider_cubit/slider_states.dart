import 'package:stylish/featuers/home/data/models/slider_model.dart';

abstract class SliderState{}

class SliderInitial extends SliderState{}

class SliderLoading extends SliderState{}

class SliderError extends SliderState{
  final String error;
  SliderError({required this.error});
}

class SliderSuccess extends SliderState{
  final SliderModel data;
  SliderSuccess({required this.data});
}
