import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utiles/app_colors.dart';
import '../utiles/app_textstyle.dart';
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double width;
  final double height;
  final Widget? icon;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.primary,
    this.textColor = Colors.white,
    this.width = 340,
    this.height = 51,
    this.icon,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 6.h,
            horizontal: 20.w,
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: (textStyle ?? AppTextStyles.monstrat18smibold600.copyWith(
                  fontSize: 23.sp
                )).copyWith(
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}