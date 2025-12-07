import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stylish/core/utiles/app_colors.dart';
import 'package:stylish/core/utiles/app_icons.dart';
import 'package:stylish/core/widgets/custom_svg.dart';
import 'package:stylish/featuers/home/views/home_body.dart';
import 'package:stylish/featuers/items/views/item_body.dart';
import 'package:stylish/featuers/main_layout/manager/user_cubit.dart';
import 'package:stylish/featuers/profile/views/profile_body.dart';
import '../../../core/helper/my_navgitor.dart';
import '../../login/data/model/login_response_model.dart';
import '../../place_order/views/cart_view.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key, this.user});
  final UserModel? user;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final pages = [
      const HomeBody(),
      const ItemBody(),
      ProfileBody(
        userModel: widget.user,
      ),
    ];

    return BlocProvider(
      create: (context) => UserCubit()..controlUser(widget.user),
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: pages,
        ),

        bottomNavigationBar: Container(
          height: 76.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 1,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.black,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            iconSize: 20.w,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                label: t.home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.grid_view_rounded),
                label: t.items,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline),
                label: t.profile,
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            MyNavigator.goTo(context, const CartScreen(), type: NavigatorType.push);
          },
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: CustomSvg(
            path: AppIcons.cartIcon,
            width: 24.w,
            height: 24.h,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
