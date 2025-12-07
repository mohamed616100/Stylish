import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
class CircleItemShimmer extends StatelessWidget {
  const CircleItemShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: ClipOval(
              child: Container(
                width: 64.w,
                height: 64.h,
                color: Colors.grey.shade300,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 50.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
