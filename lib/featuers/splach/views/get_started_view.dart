import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/helper/my_navgitor.dart';
import 'package:stylish/core/utiles/app_images.dart';
import 'package:stylish/core/widgets/custom_buttom.dart';
import 'package:stylish/featuers/register/views/register_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/utiles/app_colors.dart';
import '../../../core/utiles/app_textstyle.dart';
import '../../login/views/login_view.dart';
class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.gesStared,
              fit: BoxFit.cover,
            ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [
                   Color(0xa1000000),
                  Colors.transparent,
                ],
                stops: const [0.6, 1],
                ),
            ),
          ),


          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      t.get_started_title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.monstrat18smibold600.copyWith(
                      fontSize: 34.sp,
                      color: Colors.white,
                    )
                  ),
                  SizedBox(height: 12.h),

                  Text(
                     t.get_started_subtitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.monstrat18smibold600.copyWith(
                      fontSize: 18.sp,
                      color: AppColors.grey2,
                    )
                  ),
                  SizedBox(height: 45.h),

                 CustomButton(
                   width: 279.w,
                     height: 55.h,
                     text: t.login, onPressed:(){
                     MyNavigator.goTo(context, LoginView(),
                         type: NavigatorType.push);
                 }),
                  SizedBox(height: 16.h),

                  CustomButton(
                      width: 279.w,
                      height: 55.h,
                      color: AppColors.white,
                      textColor: AppColors.primary,
                      text: t.register, onPressed:(){
                        MyNavigator.goTo(context, RegisterView()
                            ,type: NavigatorType.push);
                  }
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

