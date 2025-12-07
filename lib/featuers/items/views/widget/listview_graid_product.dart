import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/helper/my_navgitor.dart';
import 'package:stylish/featuers/items/manager/categorie_cubit/categorie_cubit.dart';
import 'package:stylish/featuers/items/manager/categorie_cubit/categorie_states.dart';
import 'package:stylish/featuers/product/views/trending_products_view.dart';

import '../../../../core/widgets/card_prodcat_shimmer.dart';
import '../../../home/views/widgets/card_recommended.dart';

class RecommendedSliverGrid extends StatelessWidget {
  const RecommendedSliverGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategorieCubit, CategorieStates>(
      builder: (context, state) {
        final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 163 / 310,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
        );

        // show shimmer when categories or products loading
        if (state is CategorieLoading || state is CategorieProductsLoading) {
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

        if (state is CategorieProductsSuccess) {
          final products = state.products;
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

                  final price = (p.price is num)
                      ? (p.price as num).toDouble()
                      : double.tryParse('${p.price}') ?? 0.0;
                  final rating = (p.rating is num)
                      ? (p.rating as num).toDouble()
                      : double.tryParse('${p.rating}') ?? 0.0;

                  return GestureDetector(
                    onTap:(){
                      MyNavigator.goTo(context, TrendingProductsView(
                        productModel: products[index],
                      )
                          ,type: NavigatorType.push);
                    },
                    child: CardRecommended(
                      imagePath: p.imagePath ?? '',
                      discription: p.description ?? '',
                      title: p.name ?? '',
                      price: price,
                      rating: rating,
                    ),
                  );
                },
                childCount: products.length,
              ),
              gridDelegate: gridDelegate,
            ),
          );
        }


        final cubit = CategorieCubit.get(context);
        if (cubit.selectedProducts.isNotEmpty) {
          final products = cubit.selectedProducts;
          return SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final p = products[index];
                  final price = (p.price is num)
                      ? (p.price as num).toDouble()
                      : double.tryParse('${p.price}') ?? 0.0;
                  final rating = (p.rating is num)
                      ? (p.rating as num).toDouble()
                      : double.tryParse('${p.rating}') ?? 0.0;

                  return CardRecommended(
                    imagePath: p.imagePath ?? '',
                    discription: p.description ?? '',
                    title: p.name ?? '',
                    price: price,
                    rating: rating,
                  );
                },
                childCount: products.length,
              ),
              gridDelegate: gridDelegate,
            ),
          );
        }

        // error or empty default handling
        if (state is CategorieError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
                child: Text(state.message, textAlign: TextAlign.center),
              ),
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
