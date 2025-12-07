import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stylish/core/utiles/app_colors.dart';

import 'package:stylish/core/widgets/custom_appbar.dart';
import 'package:stylish/core/utiles/app_textstyle.dart';
import 'package:stylish/core/widgets/custom_buttom.dart';
import 'package:stylish/featuers/home/data/models/best_seller_model.dart';
import 'package:stylish/featuers/home/data/models/product_model.dart';
import '../../place_order/data/models/card_model.dart';
import '../../place_order/manager/cart_cubit.dart';
import '../manager/cubit.dart';

class TrendingProductsView extends StatelessWidget {
  const TrendingProductsView({
    super.key,
    this.product,
    this.productModel,
  });

  final BestSellerProducts? product;
  final Products? productModel;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final dynamic item = product ?? productModel;
    if (item == null) {
      return Scaffold(
            appBar: CustomAppBar(title: t.product),
            body: Center(
              child: Text(
                'No product found',
                style: AppTextStyles.monstrat18smibold600.copyWith(fontSize: 16.sp),
              ),
            ),
          );
    }

    final imagePath = item.imagePath as String?;
    final name = item.name as String?;
    final description = item.description as String?;
    final price = item.price;

    return Scaffold(
      appBar: CustomAppBar(title: t.product),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 27.h),
              Container(
                width: double.infinity,
                height: 308.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  image: imagePath != null && imagePath.isNotEmpty
                      ? DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imagePath),
                  )
                      : null,
                  color: Colors.grey.shade200,
                ),
                child: (imagePath == null || imagePath.isEmpty)
                    ? Center(
                  child: Icon(
                    Icons.image,
                    size: 48.r,
                    color: Colors.grey,
                  ),
                )
                    : null,
              ),
              SizedBox(height: 26.h),
              Text(
                name ?? '',
                style: AppTextStyles.monstrat18smibold600.copyWith(
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 18.h),
              Text(
                description ?? '',
                style: AppTextStyles.monstrat18smibold600.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 32.h),

              // price + counter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // price
                  Text(
                    "${price ?? 0}\$",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  BlocBuilder<AddNumberCubit, AddNumberState>(
                    builder: (context, state) {
                      final cubit = AddNumberCubit.get(context);
                      final count = cubit.number;

                      return Row(
                        children: [
                          // minus
                          GestureDetector(
                            onTap: () {
                              cubit.decrement();
                            },
                            child: Container(
                              width: 32.w,
                              height: 32.h,
                              decoration: BoxDecoration(
                                color: count > 1 ? AppColors.primary : AppColors.crossPrimary,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.remove,
                                  color: count > 1 ? Colors.white : Colors.white70,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 12.w),
                          Text(
                            count.toString(),
                            style: AppTextStyles.monstrat18smibold600.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 12.w),

                          // plus
                          GestureDetector(
                            onTap: () {
                              cubit.increment();
                            },
                            child: Container(
                              width: 32.w,
                              height: 32.h,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),

              SizedBox(height: 63.h),

              CustomButton(
                text: 'Add to cart',
                onPressed: () async {
                  final cartCubit = CartCubit.get(context);
                  final addNumberCubit = AddNumberCubit.get(context);
                  final messenger = ScaffoldMessenger.of(context);

                  final dynamic item = product ?? productModel;

                  final String id = (item.id != null)
                      ? '${item.id}'
                      : (item.name ?? DateTime.now().millisecondsSinceEpoch.toString());

                  final double itemPrice =
                  (item.price is num) ? (item.price as num).toDouble() : double.tryParse('${item.price}') ?? 0.0;

                  final int qty = addNumberCubit.number;
                  final String title = item.name ?? '';
                  final String? image = (item.imagePath ?? item.image) as String?;

                  final newItem = CartItem(
                    id: id,
                    title: title,
                    image: image,
                    price: itemPrice,
                    quantity: qty,
                  );

                  await cartCubit.addItem(newItem);

                  addNumberCubit.reset();

                  messenger.showSnackBar(
                    SnackBar(
                      content: Text('Added $title × $qty to cart'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },


              ),
            ],
          ),
        ),
      ),
    );
  }
}
