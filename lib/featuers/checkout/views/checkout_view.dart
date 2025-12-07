import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stylish/core/helper/my_navgitor.dart';

import 'package:stylish/core/utiles/app_textstyle.dart';
import 'package:stylish/core/utiles/app_colors.dart';
import 'package:stylish/core/widgets/custom_appbar.dart';
import 'package:stylish/core/widgets/custom_buttom.dart';

import '../../main_layout/views/main_layout_view.dart';
import '../../place_order/manager/cart_cubit.dart';
import '../../place_order/manager/cart_states.dart';
import '../manager/place_order_cubit/place_order_cubit.dart';
import '../manager/place_order_cubit/place_order_state.dart';
import 'map_picker_view.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String? selectedAddress;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final cartCubit = CartCubit.get(context);

    return BlocProvider(
  create: (context) => PlaceOrderCubit(),
  child: Scaffold(
      appBar: CustomAppBar(title: t.checkout),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: AppColors.primary),
                SizedBox(width: 8.w),
                Text(
                  t.delivery_address,
                  style: AppTextStyles.monstrat18smibold600.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6.r,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.address_label,
                          style: AppTextStyles.monstrat18smibold600.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          selectedAddress ?? t.address_hint,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: selectedAddress == null ? Colors.grey : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                GestureDetector(
                  onTap: () async {
                    final messenger = ScaffoldMessenger.of(context);

                    final result = await Navigator.push<Map<String, dynamic>?>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MapPickerView(),
                      ),
                    );

                    if (!mounted) return;

                    if (result != null && result['address'] != null) {
                      final address = result['address'] as String;

                      setState(() {
                        selectedAddress = address;
                      });

                      messenger.showSnackBar(
                        SnackBar(content: Text(address)),
                      );
                    }
                  },
                  child: Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Shopping List title
            Text(
              t.shopping_list,
              style: AppTextStyles.monstrat18smibold600.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),

            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  final items = cartCubit.items;

                  if (items.isEmpty) {
                    return Center(child: Text(t.cart_empty));
                  }

                  return ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final it = items[index];
                      return Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6.r,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: it.image != null
                                      ? Image.network(
                                    it.image!,
                                    width: 80.w,
                                    height: 80.h,
                                    fit: BoxFit.cover,
                                  )
                                      : Container(
                                    width: 80.w,
                                    height: 80.h,
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.image, color: Colors.grey),
                                  ),
                                ),
                                SizedBox(width: 12.w),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        it.title,
                                        style: AppTextStyles.monstrat18smibold600.copyWith(fontSize: 14.sp),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        '${it.quantity} item',
                                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        '\$${it.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            const Divider(),
                            SizedBox(height: 4.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Order (${it.quantity}) :',
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                                Text(
                                  '\$${it.total.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            SizedBox(height: 12.h),

            BlocConsumer<PlaceOrderCubit, PlaceOrderState>(
              listener: (context, state) {
                final messenger = ScaffoldMessenger.of(context);

                if (state is PlaceOrderSuccess) {
                  messenger.showSnackBar(
                    SnackBar(content: Text(t.order_success_message)),
                  );
                  CartCubit.get(context).clear();
                  MyNavigator.goTo(context, const MainLayout()
                      ,
                      type: NavigatorType.pushAndRemoveUntil);
                } else if (state is PlaceOrderError) {
                  messenger.showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is PlaceOrderLoading;

                return CustomButton(
                  text: isLoading ? t.loading : t.place_order,
                  onPressed: () {
                    if (isLoading) return;

                    final items = cartCubit.items;
                    final messenger = ScaffoldMessenger.of(context);

                    if (items.isEmpty) {
                      messenger.showSnackBar(
                        SnackBar(content: Text(t.cart_empty)),
                      );
                      return;
                    }

                    if (selectedAddress == null || selectedAddress!.isEmpty) {
                      messenger.showSnackBar(
                        SnackBar(content: Text(t.address_required_message)),
                      );
                      return;
                    }

                    final placeOrderCubit = PlaceOrderCubit.get(context);
                    placeOrderCubit.placeOrderFromCart(
                      cartItems: items,
                      address: selectedAddress!,
                    );
                  },
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
