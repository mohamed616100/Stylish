// recommended_sliver_grid.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/helper/my_navgitor.dart';
import 'package:stylish/featuers/home/manager/product_cubit/product_cubit.dart';
import 'package:stylish/featuers/home/manager/product_cubit/product_states.dart';

import '../../../../core/widgets/card_prodcat_shimmer.dart';
import '../../../product/views/trending_products_view.dart';
import 'card_recommended.dart';

class RecommendeSliverGrid extends StatelessWidget {
  const RecommendeSliverGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductStates>(
      builder: (context, state) {
        final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 163 / 310,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
        );

        if (state is ProductLoading) {
          // show shimmer placeholders as a sliver grid
          return SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => const CardProdcatShimmerCustom(),
                childCount: 6,
              ),
              gridDelegate: gridDelegate,
            ),
          );
        }

        if (state is ProductSuccess) {
          final products = state.data.products ?? [];

          if (products.isEmpty) {
            return SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Text('No recommendations', style: TextStyle(fontSize: 14.sp)),
                ),
              ),
            );
          }

          return SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final p = products[index];
                  return GestureDetector(
                    onTap: () {
                      MyNavigator.goTo(context, TrendingProductsView(
                        productModel: products[index],
                      )
                          ,type: NavigatorType.push);
                    },
                    child: CardRecommended(
                      imagePath: p.imagePath ?? '',
                      discription: p.description ?? '',
                      title: p.name ?? '',
                      price: (p.price is num) ? (p.price as num).toDouble() : double.tryParse('${p.price}') ?? 0.0,
                      rating: (p.rating is num) ? (p.rating as num).toDouble() : double.tryParse('${p.rating}') ?? 0.0,
                    ),
                  );
                },
                childCount: products.length,
              ),
              gridDelegate: gridDelegate,
            ),
          );
        }

        if (state is ProductError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
                child: Text(state.error, textAlign: TextAlign.center),
              ),
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
