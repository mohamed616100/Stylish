import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/my_navgitor.dart';
import '../../../../core/utiles/app_colors.dart';
import '../../../../core/utiles/app_textstyle.dart';
import '../../../../core/widgets/CircleItemShimmer.dart';
import '../../../product/views/trending_products_view.dart';
import '../../manager/best_seller_cubit/best_seller_cubit.dart';
import '../../manager/best_seller_cubit/best_seller_states.dart';
import 'bestseller_circle_item.dart';

class BestsellerCircleListview extends StatelessWidget {
  const BestsellerCircleListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BestSellerCubit, BestSellerState>(
      builder: (context, state){
        if(state is BestSellerLoading){
          return SizedBox(
            height: 100.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              itemBuilder: (_, __) => const CircleItemShimmer(),
            ),
          );
        }else if( state is BestSellerSuccess){
          return SizedBox(
            height: 100.h,
            child: ListView.builder(
              itemBuilder: (context, index) {
                final product = state.data.bestSellerProducts![index];
                return BestsellerCircleItem(
                  color: AppColors.grey1,
                  title: product.name??'No Name',
                  imagePath: product.imagePath!,
                  onTap: () {
                    MyNavigator.goTo(context, TrendingProductsView(
                      product: state.data.bestSellerProducts![index],
                    ),type: NavigatorType.push);
                  },
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
              ),
            ),
          );
        }else if(state is BestSellerError){
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.error,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.monstrat18smibold600.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.grey1,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      BestSellerCubit.get(context).getBestSeller();
                    },
                    child: const Text('retry'),
                  ),
                ],
              ),
            ),
          );
        }else{
          return const SizedBox.shrink();
        }
      },
    );
  }
}
