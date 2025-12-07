import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:stylish/core/utiles/app_textstyle.dart';
class BestsellerCircleItem extends StatelessWidget {
  const BestsellerCircleItem({super.key,
    required this.title,
    required this.imagePath,
    this.onTap,
    required this.color
  });
  final String title;
  final String imagePath;
  final VoidCallback? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.only(
        right: 15.w,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: imagePath,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 64.w,
                    height: 64.h,
                    color: Colors.grey.shade300,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.error, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              title,
              style: AppTextStyles.monstrat18smibold600.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: color
              )
            ),
            ]
        ),
      ),
    );
  }
}