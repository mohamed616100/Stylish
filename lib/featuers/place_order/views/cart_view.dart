import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stylish/core/helper/app_toast.dart';
import 'package:stylish/featuers/checkout/views/checkout_view.dart';
import '../manager/cart_cubit.dart';
import '../manager/cart_states.dart';
import 'package:stylish/core/utiles/app_textstyle.dart';
import 'package:stylish/core/utiles/app_colors.dart';
import 'package:stylish/core/widgets/custom_appbar.dart';
import 'package:stylish/core/widgets/custom_buttom.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(title: t.cart),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  final cubit = CartCubit.get(context);
                  final items = cubit.items;

                  if (items.isEmpty) {
                    return Center(child: Text(t.cart_empty));
                  }

                  return ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => SizedBox(height: 14.h),
                    itemBuilder: (context, index) {
                      final it = items[index];

                      return Dismissible(
                        key: ValueKey(it.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(Icons.delete, color: Colors.white, size: 28.sp),
                        ),
                        confirmDismiss: (direction) async {
                          final cartCubit = CartCubit.get(context);
                          final messenger = ScaffoldMessenger.of(context);
                          final itemTitle = it.title;
                          final itemId = it.id;

                          final shouldDelete = await showDialog<bool>(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: Text('Delete Item'),
                                content: Text('Are you sure you want to delete "$itemTitle"?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(ctx).pop(false),
                                    child: Text(t.cancel),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(ctx).pop(true),
                                    child: Text('Delete', style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              );
                            },
                          );

                          if (shouldDelete == true) {
                            await cartCubit.removeItem(itemId);

                            messenger.showSnackBar(
                              SnackBar(
                                content: Text('$itemTitle removed from cart'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );

                            return true; // allow Dismissible animation
                          }

                          return false;
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6.r,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: it.image != null
                                        ? Image.network(it.image!, width: 80.w, height: 80.h, fit: BoxFit.cover)
                                        : Container(width: 80.w, height: 80.h, color: Colors.grey[200]),
                                  ),
                                  SizedBox(width: 12.w),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(it.title,
                                            style: AppTextStyles.monstrat18smibold600.copyWith(fontSize: 16.sp)),
                                        SizedBox(height: 8.h),
                                        Text('\$${it.price.toStringAsFixed(2)}',
                                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),

                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => CartCubit.get(context).increment(it.id),
                                        child: Container(
                                          width: 32.w,
                                          height: 32.h,
                                          decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8.r)),
                                          child: const Icon(Icons.add, color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(it.quantity.toString(), style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                                      SizedBox(height: 6.h),
                                      GestureDetector(
                                        onTap: () => CartCubit.get(context).decrement(it.id),
                                        child: Container(
                                          width: 32.w,
                                          height: 32.h,
                                          decoration: BoxDecoration(
                                              color: it.quantity > 1 ? AppColors.primary : AppColors.crossPrimary,
                                              borderRadius: BorderRadius.circular(8.r)),
                                          child: const Icon(Icons.remove, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),

                              SizedBox(height: 12.h),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total (${it.quantity}) :', style: TextStyle(fontSize: 14.sp)),
                                  Text('\$${it.total.toStringAsFixed(2)}', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            Divider(),

            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                final cubit = CartCubit.get(context);
                return Column(
                  children: [
                    _totalsRow(t.subtotal, '\$${cubit.subtotal.toStringAsFixed(2)}'),
                    SizedBox(height: 8.h),
                    _totalsRow(t.tax_fees, '\$${cubit.taxAndFees.toStringAsFixed(2)}'),
                    SizedBox(height: 8.h),
                    _totalsRow(t.delivery_fee, '\$${cubit.deliveryFee.toStringAsFixed(2)}'),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(t.order_total, style: AppTextStyles.monstrat18smibold600.copyWith(fontSize: 18.sp)),
                        Text('\$${cubit.orderTotal.toStringAsFixed(2)}',
                            style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 18.sp)),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    CustomButton(
                      text: t.checkout,
                      onPressed: () {
                        final cartCubit = CartCubit.get(context);

                        if (cartCubit.items.isEmpty) {
                         AppToast.show(context, t.cart_empty);
                          return;
                        }

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: cartCubit,
                              child: const CheckoutView(),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 8.h),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _totalsRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 16.sp, color: Colors.black87)),
        Text(value, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
