import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../featuers/search/views/custom_search_delegate.dart';
import '../utiles/app_colors.dart';
import '../utiles/app_textstyle.dart';
class BoxSearchWidget extends StatelessWidget {
  const BoxSearchWidget({super.key});
  @override
  Widget build(BuildContext context) {
   final t = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        showSearch(
          context: context,
          delegate: CustomSearchDelegate(),
        );
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 9,
              )
            ]
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: AppColors.black, size: 22),
            SizedBox(width: 10),
            Text(
                t.search_any_product,
                style: AppTextStyles.monstrat18smibold600.copyWith(
                  color: AppColors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                )
            ),
          ],
        ),
      ),
    );
  }
}
