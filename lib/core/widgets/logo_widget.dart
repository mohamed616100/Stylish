import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utiles/app_icons.dart';
import '../utiles/app_textstyle.dart';
import 'custom_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomSvg(
          path: AppIcons.splachIcon
          ,height: 32.h,
          width: 39.w,
        ),
        SizedBox(width: 5.w,),
        Text(
          t.appTitle,
          style: AppTextStyles.headline1.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xff4392F9),
          ),
        )
      ],
    );
  }
}
