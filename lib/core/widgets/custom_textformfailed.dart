import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utiles/app_colors.dart';
class CustomTextformfaild extends StatelessWidget {
  CustomTextformfaild({super.key,
    required this.obscureText,
    required this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.validator,
    required this.hintText,
    this.OnTap,
    this.initialValue,
  });
  final String? initialValue;
  Widget ?prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  Widget ?suffixIcon;
  TextEditingController? controller;
  String? Function(String?)? validator;
  final String hintText;
  void Function()? OnTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:55.h,
      width: 317.w,
      child: TextFormField(
        style:TextStyle(
          fontSize: 14.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w600
        ),
        onTap: OnTap,
        validator: validator,
        initialValue:initialValue,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        obscuringCharacter: "*",
        cursorColor: AppColors.primary,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            hintText: hintText,
            fillColor: AppColors.grey4,
            filled: true,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            alignLabelWithHint: true,

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: AppColors.grey1,
                width: 2.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: AppColors.grey1,
                width: 2.w,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: Colors.red,
                width: 2.w,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: Colors.red,
                width: 2.w,
              ),
            ),
          )
      ),
    );
  }
}
