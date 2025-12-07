import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/ theme/them_manager/them_cubit.dart';
import '../../../../core/ theme/them_manager/them_state.dart';
class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});
  @override
  Widget build(BuildContext context) {
    final t= AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
             t.theme,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),

        BlocBuilder<ThemCubit, ThemState>(
          builder: (context, state) {
            final cubit = ThemCubit.get(context);
            final isDark = cubit.isDark;

            return Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE3EA),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Light
                  GestureDetector(
                    onTap: () {
                      if (isDark) {
                        cubit.toggleTheme();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: !isDark
                            ? const Color(0xFFFF2850)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        'Light',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: !isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),

                  // Dark
                  GestureDetector(
                    onTap: () {
                      if (!isDark) {
                        cubit.toggleTheme();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFFFF2850)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        'Dark',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
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
