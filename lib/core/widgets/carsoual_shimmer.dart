import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
class CarsolShimmer extends StatelessWidget {
  const CarsolShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return  CarouselSlider.builder(
      itemCount: 3,
      itemBuilder: (context, index, realIndex) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            height: 128.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade300,
                  child: Container(
                    height: 128.h,
                    width: 161.5.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        bottomLeft: Radius.circular(20.r),
                      ),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade300,
                  child: Container(
                    height: 128.h,
                    width: 161.5.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 128.h,
        autoPlay: false,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
      ),
    );
  }
}
