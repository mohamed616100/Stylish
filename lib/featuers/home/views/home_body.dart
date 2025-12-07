import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stylish/core/utiles/app_colors.dart';
import 'package:stylish/core/widgets/box_search_widget.dart';
import 'package:stylish/core/widgets/logo_widget.dart';
import 'package:stylish/featuers/home/views/widgets/bestseller_circle_listview.dart';
import 'package:stylish/featuers/home/views/widgets/cursal_slider_widget.dart';
import 'package:stylish/featuers/home/views/widgets/recommende_listview.dart';
import '../../../core/helper/my_navgitor.dart';
import '../../../core/utiles/app_textstyle.dart';
import '../../best_seller/views/best_seller_view.dart';
import '../manager/best_seller_cubit/best_seller_cubit.dart';
import '../manager/best_seller_cubit/best_seller_states.dart';
import '../manager/product_cubit/product_cubit.dart';
import '../manager/slider_cubit/slider_cubit.dart';
class HomeBody extends StatelessWidget {
  const HomeBody({super.key});
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BestSellerCubit()..getBestSeller()),
        BlocProvider(create: (_) => SliderCubit()..getSlider()),
        BlocProvider(create: (_) => ProductCubit()..getProduct()),
      ],
      child: SafeArea(
        child: Builder(builder: (context) {
          final bestCubit = BestSellerCubit.get(context);
          final sliderCubit = SliderCubit.get(context);
          final productCubit = ProductCubit.get(context);

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              try {
                await Future.wait([
                  Future.sync(() => bestCubit.getBestSeller()),
                  Future.sync(() => sliderCubit.getSlider()),
                  Future.sync(() => productCubit.getProduct()),
                ]);
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Refresh failed: ${e.toString()}')),
                  );
                }
              }
            },
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
                        const LogoWidget(),
                        SizedBox(height: 23.h),
                        const BoxSearchWidget(),
                        SizedBox(height: 17.h),
                        Row(
                          children: [
                            Text(
                              t.best_seller,
                              style: AppTextStyles.monstrat18smibold600.copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                final state = BestSellerCubit.get(context).state;
                                if (state is BestSellerSuccess) {
                                  MyNavigator.goTo(
                                    context,
                                    BestSellerView(
                                      data: state.data, // BestSellerModel
                                    ),
                                  );
                                } else {
                                  final isLoading = state is BestSellerLoading;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        isLoading ? 'Please wait, loading...' : 'Unable to open. Try again.',
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Row(
                                children: [
                                  Text(t.view_all,
                                    style: AppTextStyles.monstrat18smibold600.copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25.h),
                      ],
                    ),
                  ),
                ),

                // Best seller horizontal list
                SliverToBoxAdapter(child: const BestsellerCircleListview()),
                SliverToBoxAdapter(child: SizedBox(height: 24.h)),

                // Carousel slider
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: const CarsulSliderWidget(),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 50.h)),

                // Recommended header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 23.w),
                    child: Text(
                      t.recommended,
                      style: AppTextStyles.monstrat18smibold600,
                    ),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 24.h)),

                const RecommendeSliverGrid(),

                SliverToBoxAdapter(child: SizedBox(height: 15.h)),
              ],
            ),
          );
        }),
      ),
    );
  }
}
