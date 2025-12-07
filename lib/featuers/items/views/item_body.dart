import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stylish/featuers/items/views/widget/listview_catgory.dart';
import 'package:stylish/featuers/items/views/widget/listview_graid_product.dart';
import '../../../core/utiles/app_colors.dart';
import '../../../core/utiles/app_textstyle.dart';
import '../../../core/widgets/logo_widget.dart';
import '../manager/categorie_cubit/categorie_cubit.dart';
class ItemBody extends StatelessWidget {
  const ItemBody({super.key});
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => CategorieCubit()..getCategorie(),
      child: SafeArea(
        child: Builder(
          builder: (ctx) {
            return RefreshIndicator(
              onRefresh: () async {
                await CategorieCubit.get(ctx).getCategorie();
              },
               color: AppColors.primary,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.h),
                          LogoWidget(),
                          SizedBox(height: 40.h),
                          Text(
                            t.all_featured,
                            style: AppTextStyles.monstrat18smibold600.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 25.h),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: ListviewCatgory()),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 42.h),
                          Text(
                            t.products,
                            style: AppTextStyles.monstrat18smibold600.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                  const RecommendedSliverGrid(),
                  SliverToBoxAdapter(child: SizedBox(height: 15.h)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
