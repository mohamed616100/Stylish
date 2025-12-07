import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utiles/app_colors.dart';
import 'package:stylish/core/utiles/app_icons.dart';
import 'package:stylish/core/utiles/app_images.dart';
import 'package:stylish/core/widgets/custom_svg.dart';

class CustomAuthImage extends StatelessWidget {
  const CustomAuthImage({
    super.key,
    this.image = const AssetImage(AppImages.Placeholder),
  });

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // MAIN IMAGE
        Container(
          height: 90.w,
          width: 90.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary.withOpacity(0.6), width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
        ),

        // CAMERA BUTTON
        Positioned(
          bottom: -4,
          right: -4,
          child: Container(
            height: 32.w,
            width: 32.w,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Center(
              child: CustomSvg(
                path: AppIcons.CameraIcon,
                width: 18.w,
                height: 18.h,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
