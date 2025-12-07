import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utiles/app_colors.dart';
import '../../../../core/utiles/app_textstyle.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.titleColor,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color? titleColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22.sp,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.monstrat18smibold600.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }
}