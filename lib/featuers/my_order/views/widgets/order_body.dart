import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/helper/date_helper.dart';
import '../../../../core/utiles/app_colors.dart';
import '../../../../core/utiles/app_textstyle.dart';

import '../../../order_details_view/views/order_details_view.dart';
import '../../data/model/order_model.dart';
import '../../manager/order_cubit/order_cubit.dart';
import '../../manager/order_cubit/order_states.dart';

class OrdersBody extends StatelessWidget {
  const OrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final cubit = OrdersCubit.get(context);
        if (state is OrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is OrdersError) {
          return Center(child: Text(state.message));
        }

        OrdersResponse? data;
        OrdersTab tab = OrdersTab.active;

        if (state is OrdersSuccess) {
          data = state.data;
          tab = state.tab;
        } else if (state is OrdersTabChanged) {
          data = state.data;
          tab = state.tab;
        } else {
          return const SizedBox.shrink();
        }

        List<OrderModel> list;
        switch (tab) {
          case OrdersTab.completed:
            list = data.orders.completed;
            break;
          case OrdersTab.canceled:
            list = data.orders.canceled;
            break;
          case OrdersTab.active:
            list = data.orders.active;
        }

        if (list.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.receipt_long, size: 80.r, color: AppColors.primary),
                SizedBox(height: 16.h),
                Text(
                  t.no_active_orders_message,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.monstrat18smibold600.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          itemCount: list.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final order = list[index];
            final firstItem = order.items.isNotEmpty ? order.items.first : null;

            return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: cubit,
                    child: OrderDetailsView(
                      order: order,
                      tab: tab,
                    ),
                  ),
                ),
              );
            },
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
                  Row(
                    children: [
                      if (firstItem != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.network(
                            firstItem.imagePath,
                            width: 80.w,
                            height: 80.h,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        Container(
                          width: 80.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: const Icon(Icons.image, color: Colors.grey),
                        ),
                      SizedBox(width: 12.w),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formatOrderDate(order.orderDate),
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              firstItem?.name ?? 'Order #${order.id}',
                              style: AppTextStyles.monstrat18smibold600.copyWith(
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '${order.items.length} item${order.items.length > 1 ? 's' : ''}',
                              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              '\$${order.total.toStringAsFixed(2)}',
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
                  _buildBottomRow(context, tab, t, order),
                ],
              ),
            ),
            );
          },
        );
      },
    );
  }

  Widget _buildBottomRow(
      BuildContext context,
      OrdersTab tab,
      AppLocalizations t,
      OrderModel order,
      ) {
    switch (tab) {
      case OrdersTab.active:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                final cubit = OrdersCubit.get(context);
                cubit.cancelOrder(order.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(t.cancelled)),
                );
                Navigator.of(context).pop();
              },
              child: _smallFilledButton(t.cancel),
            ),
          ],
        );

      case OrdersTab.completed:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 16.r),
            SizedBox(width: 4.w),
            Text(
              'Order delivered',
              style: TextStyle(fontSize: 12.sp, color: Colors.green),
            ),
          ],
        );

      case OrdersTab.canceled:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.cancel, color: Colors.red, size: 16.r),
            SizedBox(width: 4.w),
            Text(
              'Order canceled',
              style: TextStyle(fontSize: 12.sp, color: Colors.red),
            ),
          ],
        );
    }
  }

  Widget _smallFilledButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.sp,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
