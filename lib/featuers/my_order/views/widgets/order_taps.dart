import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/utiles/app_colors.dart';
import '../../../../core/utiles/app_textstyle.dart';
import '../../manager/order_cubit/order_cubit.dart';
import '../../manager/order_cubit/order_states.dart';


class OrdersTabs extends StatelessWidget {
  const OrdersTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final cubit = OrdersCubit.get(context);
        final current = cubit.currentTab;

        Widget buildChip(String text, OrdersTab tab) {
          final isSelected = current == tab;
          return GestureDetector(
            onTap: () => cubit.changeTab(tab),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
              margin: EdgeInsets.only(right: 8.w),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                text,
                style: AppTextStyles.monstrat18smibold600.copyWith(
                  fontSize: 12.sp,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ),
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildChip(t.active, OrdersTab.active),
            buildChip(t.completed, OrdersTab.completed),
            buildChip(t.cancelled, OrdersTab.canceled),
          ],
        );
      },
    );
  }
}
