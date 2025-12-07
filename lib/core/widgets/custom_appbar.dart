import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/helper/my_navgitor.dart';
import 'package:stylish/core/utiles/app_icons.dart';
import 'package:stylish/core/widgets/custom_svg.dart';
import '../utiles/app_textstyle.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;
  final Color? titleColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.actions,
    this.backgroundColor,
    this.elevation,
    this.titleColor,
  });

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding:EdgeInsets.symmetric(horizontal: 23.w),
      child: AppBar(
        backgroundColor: backgroundColor ?? theme.appBarTheme.backgroundColor,
        elevation: elevation ?? theme.appBarTheme.elevation ?? 0,
        centerTitle: true,
        leading: showBack
            ? IconButton(
          onPressed: () => MyNavigator.goBack(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: titleColor ?? theme.appBarTheme.foregroundColor,
            size: 23.sp,
          )
        )
            : null,
        title: Text(
          title,
          style: AppTextStyles.monstrat18smibold600.copyWith(
            fontSize: 20.sp,
            color: titleColor ?? theme.appBarTheme.foregroundColor,
          ),
        ),
        actions: actions,
      ),
    );
  }
}
