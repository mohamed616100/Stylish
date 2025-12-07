import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:stylish/core/utiles/app_textstyle.dart';
import 'package:stylish/core/widgets/custom_svg.dart';
import 'package:stylish/featuers/splach/data/data_onbording.dart';
import '../../../core/utiles/app_colors.dart';
import '../manager/onbording_cubit.dart';
import '../manager/onbording_state.dart';

class OnbordingView extends StatelessWidget {
  const OnbordingView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final onb = OnboardingItem.onboardingItems;

    return BlocProvider(
      create: (_) => OnboardingCubit(pagesCount: onb.length),
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          final cubit = OnboardingCubit.of(context);

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [

                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: 12.h, right: 16.w),
                      child: TextButton(
                        onPressed: state.currentIndex == onb.length - 1
                            ? null
                            : () => cubit.skip(),
                        child: Text(
                          t.skip,
                          style: AppTextStyles.monstrat18smibold600.copyWith(
                            color: state.currentIndex == onb.length - 1
                                ? Colors.transparent
                                : AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// PageView
                  Expanded(
                    child: PageView.builder(
                      controller: cubit.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: onb.length,
                      onPageChanged: cubit.onPageChanged,
                      itemBuilder: (context, index) {
                        final item = onb[index];

                        String title;
                        String desc;

                        switch (index) {
                          case 0:
                            title = t.onboarding_choose_title;
                            desc = t.onboarding_choose_desc;
                            break;
                          case 1:
                            title = t.onboarding_pay_title;
                            desc = t.onboarding_pay_desc;
                            break;
                          case 2:
                          default:
                            title = t.onboarding_order_title;
                            desc = t.onboarding_order_desc;
                            break;
                        }

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 260.h,
                              child: CustomSvg(path: item.imagePath),
                            ),
                            SizedBox(height: 30.h),

                            /// العنوان
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.monstrat24smibold800,
                            ),

                            SizedBox(height: 12.h),

                            /// الوصف
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Text(
                                desc,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.monstrat18smibold600
                                    .copyWith(
                                  color: AppColors.grey1,
                                  height: 1.5,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  /// Indicators + Prev / Next
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 28.h,
                      left: 16.w,
                      right: 16.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Prev
                        TextButton(
                          onPressed: state.currentIndex == 0
                              ? null
                              : () => cubit.prev(cubit.pageController),
                          child: Text(
                            t.prev,
                            style: AppTextStyles.monstrat18smibold600.copyWith(
                              color: state.currentIndex == 0
                                  ? Colors.transparent
                                  : AppColors.grey2,
                            ),
                          ),
                        ),

                        /// Dots
                        SmoothPageIndicator(
                          controller: cubit.pageController,
                          count: onb.length,
                          effect: ExpandingDotsEffect(
                            activeDotColor: AppColors.primary,
                            dotColor: AppColors.grey3,
                            dotHeight: 8.h,
                            dotWidth: 8.w,
                            expansionFactor: 3,
                            spacing: 8.w,
                          ),
                        ),

                        /// Next / Get started
                        TextButton(
                          onPressed: () =>
                              cubit.next(cubit.pageController, context),
                          child: Text(
                            state.isLast ? t.get_started : t.next,
                            style: AppTextStyles.monstrat18smibold600.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
