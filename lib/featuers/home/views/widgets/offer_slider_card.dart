import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/helper/app_image_cache.dart';
class OfferSliderCard extends StatelessWidget {
  const OfferSliderCard({
    required this.title,
    required this.subtitle1,
    required this.buttonText,
    required this.imagePath,
    this.onTap,
  });

  final String title;
  final String subtitle1;
  final String buttonText;
  final String imagePath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xffFF8CAB),
            Color(0xffFF5F8A),
          ],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  subtitle1,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                SizedBox(height: 4.h),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          buttonText,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xffFF5F8A),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        const Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: Color(0xffFF5F8A),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.bottomRight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: CachedNetworkImage(
                  placeholderFadeInDuration: Duration.zero,
                  cacheManager: AppImageCache.instance,
                  useOldImageOnUrlChange: true,
                  imageUrl: imagePath,
                  height: 190.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 140.h,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 190.h,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
