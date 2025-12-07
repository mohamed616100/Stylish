import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/featuers/home/views/widgets/offer_slider_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/widgets/carsoual_shimmer.dart';
import '../../manager/slider_cubit/slider_cubit.dart';
import '../../manager/slider_cubit/slider_states.dart';
class CarsulSliderWidget extends StatelessWidget {
  const CarsulSliderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return BlocBuilder<SliderCubit, SliderState>(
      builder: (context, state) {
        if (state is SliderLoading) {
          return CarsolShimmer();
        }
        else if(state is SliderSuccess){
          final cubit= SliderCubit.get(context);
          return CarouselSlider.builder(
            carouselController:cubit.controller,
            itemCount: state.data.sliders!.length,
            itemBuilder: (context, index, realIndex) {
              final slider = state.data.sliders![index];
              return OfferSliderCard(
                  title: slider.title!,
                  subtitle1: slider.description!,
                  buttonText: t.shop_now,
                  imagePath: slider.imagePath!
              );
            },
            options:CarouselOptions(
              height: 220.h,
              autoPlay: true,
              viewportFraction: 1.0,
              enlargeCenterPage: true,
              onPageChanged:cubit.onPageChanged,
            ),
          );
        }else if(state is SliderError){
          return SizedBox(
              height: 128.h,
              child: Center(child: Text(state.error),));
        }else{
          return Container();
        }
      },
    );
  }
}
