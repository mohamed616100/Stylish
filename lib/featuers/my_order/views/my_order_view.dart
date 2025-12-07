import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/featuers/my_order/views/widgets/order_body.dart';
import 'package:stylish/featuers/my_order/views/widgets/order_taps.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/widgets/custom_appbar.dart';

import '../data/repo/order_repo.dart';
import '../manager/order_cubit/order_cubit.dart';
import '../manager/order_cubit/order_states.dart';

class MyOrderView extends StatelessWidget {
  const MyOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => OrdersCubit(OrdersRepo())..getOrders(),
      child: BlocListener<OrdersCubit, OrdersState>(
        listener: (context, state) {
          final messenger = ScaffoldMessenger.of(context);
          if (state is CancelOrderSuccess) {
            messenger.showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is CancelOrderError) {
            messenger.showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
          appBar: CustomAppBar(title: t.my_orders),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                const OrdersTabs(),
                SizedBox(height: 16.h),
                const Expanded(child: OrdersBody()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
