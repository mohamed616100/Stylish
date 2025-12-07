import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utiles/app_textstyle.dart';

import '../../../../core/helper/app_image_cache.dart';

class CardRecommended extends StatelessWidget {
  const CardRecommended({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.rating,
    required this.discription,
  });

  final String imagePath;
  final String discription;
  final String title;
  final double price;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            color: Colors.black.withOpacity(0.15),
            blurRadius: 2,
          )
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CachedNetworkImage(
              imageUrl: imagePath,
              placeholderFadeInDuration: Duration.zero,
              cacheManager: AppImageCache.instance,
              useOldImageOnUrlChange: true,
              height: 195.h,
              width: double.infinity,
              fit: BoxFit.cover,

              placeholder: (context, url) => Container(
                height: 195.h,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),

              errorWidget: (context, url, error) => Container(
                height: 195.h,
                color: Colors.grey.shade200,
                alignment: Alignment.center,
                child: Icon(Icons.broken_image, size: 40),
              ),
            ),
          ),
          // ---- CONTENT ----
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.monstrat18smibold600.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),

                Text(
                  discription,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.monstrat18smibold600.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 6.h),

                Text(
                  "\$${price.toStringAsFixed(0)}",
                  style: AppTextStyles.monstrat18smibold600.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),

                Row(
                  children: [
                    _buildStars(rating),
                    SizedBox(width: 4.w),
                    Text(
                      rating.toStringAsFixed(1),
                      style: AppTextStyles.monstrat18smibold600.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildStars(double rating) {
  final full = rating.floor();
  final half = (rating - full) >= 0.5;
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(5, (i) {
      if (i < full) return const Icon(Icons.star, size: 14, color: Colors.amber);
      if (i == full && half) return const Icon(Icons.star_half, size: 14, color: Colors.amber);
      return const Icon(Icons.star_border, size: 14, color: Colors.amber);
    }),
  );
}
