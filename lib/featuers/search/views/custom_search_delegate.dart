import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/helper/my_navgitor.dart';
import 'package:stylish/featuers/home/views/widgets/card_recommended.dart';
import 'package:stylish/featuers/product/views/trending_products_view.dart';

import '../../../core/widgets/card_prodcat_shimmer.dart';
import '../manager/search_cubit.dart';
import '../manager/search_state.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          SearchCubit.get(context).getSearch(q: query);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          close(context, null);
        },
      );
  }

  @override
  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 163 / 310,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
            ),
            itemCount: 6,
            itemBuilder: (context, index) => const CardProdcatShimmerCustom(),
          );
        }

        if (state is SearchSuccess) {
          final products = state.data.products ?? [];

          if (products.isEmpty) {
            return const Center(child: Text('No recommendations'));
          }

          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 163 / 310,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              return GestureDetector(
                onTap: (){
                  MyNavigator.goTo(context, TrendingProductsView(
                    productModel: p ,
                  )
                      ,type: NavigatorType.push);
                },
                child: CardRecommended(
                  imagePath: p.imagePath ?? '',
                  discription: p.description ?? '',
                  title: p.name ?? '',
                  price: (p.price is num)
                      ? (p.price as num).toDouble()
                      : double.tryParse('${p.price}') ?? 0.0,
                  rating: (p.rating is num)
                      ? (p.rating as num).toDouble()
                      : double.tryParse('${p.rating}') ?? 0.0,
                ),
              );
            },
          );
        }

        if (state is SearchError) {
          return Center(
            child: Text(state.error),
          );
        }

        return const Center(child: Text('No recommendations'));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text(
          "Type something to search...",
          style:Theme.of(context).textTheme.bodyMedium,
        ),
      );
    } else {
      SearchCubit.get(context).getSearch(q: query);
      return buildResults(context);
    }
  }
}