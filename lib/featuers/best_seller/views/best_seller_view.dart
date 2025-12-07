import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/helper/my_navgitor.dart';
import 'package:stylish/core/widgets/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stylish/featuers/home/data/models/best_seller_model.dart';
import 'package:stylish/featuers/product/views/trending_products_view.dart';

import '../../home/views/widgets/card_recommended.dart';
class BestSellerView extends StatelessWidget {
  const BestSellerView({super.key, required this.data});
  final BestSellerModel data;
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(title:t.best_seller),
      body:GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 163 / 310,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
        ),
        itemCount: data.bestSellerProducts!.length,
        itemBuilder: (context, index) {
          final p = data.bestSellerProducts![index];
          return GestureDetector(
            onTap: () {
              MyNavigator.goTo(context, TrendingProductsView(
                product: data.bestSellerProducts![index],
              ),
                  type: NavigatorType.push);
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
      )
    );
  }
}
