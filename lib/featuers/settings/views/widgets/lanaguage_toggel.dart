import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/local/cubit.dart';
class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          t.lang,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            final cubit = LocaleCubit.of(context);
            final isArabic = state.locale.languageCode == 'ar';

            return Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE3EA),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // AR
                  GestureDetector(
                    onTap: () {
                      if (!isArabic) cubit.setArabic();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: isArabic
                            ? const Color(0xFFFF2850)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        'AR',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                          isArabic ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),

                  // EN
                  GestureDetector(
                    onTap: () {
                      if (isArabic) cubit.setEnglish();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: !isArabic
                            ? const Color(0xFFFF2850)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        'EN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                          !isArabic ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
