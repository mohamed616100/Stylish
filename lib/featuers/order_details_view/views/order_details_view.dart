import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stylish/featuers/my_order/manager/order_cubit/order_cubit.dart';

import '../../../../core/utiles/app_colors.dart';
import '../../../../core/utiles/app_textstyle.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/helper/date_helper.dart';
import '../../my_order/data/model/order_model.dart';
import '../../my_order/manager/order_cubit/order_states.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({
    super.key,
    required this.order,
    required this.tab,
  });

  final OrderModel order;
  final OrdersTab tab;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final statusText = _statusText(tab, t);
    final statusColor = _statusColor(tab);

    return Scaffold(
      appBar: CustomAppBar(title: t.order_details),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' ${order.id}',
                      style: AppTextStyles.monstrat18smibold600.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      formatOrderDate(order.orderDate),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            Expanded(
              child: ListView.separated(
                itemCount: order.items.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final item = order.items[index];
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
                              child: Image.network(
                                item.imagePath,
                                width: 80.w,
                                height: 80.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: AppTextStyles.monstrat18smibold600
                                        .copyWith(fontSize: 14.sp),
                                  ),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      Text(
                                        item.rating.toStringAsFixed(1),
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                      Icon(
                                        Icons.star,
                                        size: 14.r,
                                        color: Colors.amber,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    '${item.quantity} item',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    '\$${item.price.toStringAsFixed(2)}',
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
                              '${t.total_order} (${item.quantity}) :',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            Text(
                              '\$${item.totalPrice.toStringAsFixed(2)}',
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
              ),
            ),

            SizedBox(height: 12.h),

            _priceRow(t.subtotal, order.subtotal),
            SizedBox(height: 4.h),
            _priceRow(t.tax_fees, order.tax),
            SizedBox(height: 4.h),
            _priceRow(t.delivery_fee, order.shipping),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.order_total,
                  style: AppTextStyles.monstrat18smibold600.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  '\$${order.total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            if (tab == OrdersTab.active)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  onPressed: () {
                    OrdersCubit.get(context).cancelOrder(order.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(t.cancelled)),
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    t.cancelled,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _statusText(OrdersTab tab, AppLocalizations t) {
    switch (tab) {
      case OrdersTab.active:
        return t.active;
      case OrdersTab.completed:
        return t.completed;
      case OrdersTab.canceled:
        return t.cancelled;
    }
  }

  Color _statusColor(OrdersTab tab) {
    switch (tab) {
      case OrdersTab.active:
        return AppColors.primary;
      case OrdersTab.completed:
        return Colors.green;
      case OrdersTab.canceled:
        return Colors.red;
    }
  }

  Widget _priceRow(String title, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 13.sp, color: Colors.black87),
        ),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
