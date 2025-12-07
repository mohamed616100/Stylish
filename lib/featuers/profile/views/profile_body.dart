import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stylish/core/helper/app_toast.dart';
import 'package:stylish/core/helper/logout_helper.dart';
import 'package:stylish/core/helper/my_navgitor.dart';
import 'package:stylish/core/utiles/app_colors.dart';
import 'package:stylish/core/utiles/app_images.dart';
import 'package:stylish/core/utiles/app_textstyle.dart';
import 'package:stylish/featuers/login/data/model/login_response_model.dart';
import 'package:stylish/featuers/my_order/views/my_order_view.dart';
import 'package:stylish/featuers/profile/views/widgets/profile_item.dart';

import '../../main_layout/manager/user_cubit.dart';
import '../../main_layout/manager/user_state.dart';
import '../../settings/views/setting_view.dart';
import '../../splach/views/get_started_view.dart';
import '../../update_profile/view/update_profile_view.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key, this.userModel});

  final UserModel? userModel;

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  Future<void> _onLogoutPressed() async {
    final t = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          t.logout,
          style: AppTextStyles.monstrat18smibold600,
        ),
        content: Text(
          t.logout_confirm_message,
          style: AppTextStyles.monstrat18smibold600.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.grey1,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              t.cancel,
              style: AppTextStyles.monstrat18smibold600.copyWith(
                fontSize: 14.sp,
                color: AppColors.grey2,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              t.logout,
              style: AppTextStyles.monstrat18smibold600.copyWith(
                fontSize: 14.sp,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final success = await LogoutHelper.logout();

    if (!mounted) return;

    if (success) {
      MyNavigator.goTo(
        context,
        const GetStartedView(),
        type: NavigatorType.pushAndRemoveUntil,
      );
      AppToast.success(context, t.logout_success);
    } else {
      AppToast.error(context, t.logout_failed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            } else if (state is UserError) {
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
                          UserCubit.get(context).getUser();
                        },
                        child: const Text('retry'),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is UserSuccess) {
              final user = widget.userModel ?? state.user;
              final imagePath = user.imagePath;
              final userName = user.name ?? 'guest';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 8.h),

                  /// Title
                  Text(
                    t.profile,
                    style: AppTextStyles.monstrat24smibold800.copyWith(
                      fontSize: 20.sp,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  /// Avatar
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: imagePath ?? '',
                      width: 96.w,
                      height: 96.h,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 96.w,
                          height: 96.h,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        AppImages.Placeholder,
                        width: 96.w,
                        height: 96.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  /// User Name
                  Text(
                    userName,
                    style: AppTextStyles.monstrat18smibold600.copyWith(
                      fontSize: 18.sp,
                      color: AppColors.primary,
                    ),
                  ),

                  SizedBox(height: 32.h),

                  /// Menu items
                  ProfileItem(
                    icon: Icons.person_outline,
                    title: t.my_profile,
                    onTap: () {
                      final userCubit = UserCubit.get(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: userCubit,
                            child: UpdateProfileView(
                              userModel:
                              user,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ProfileItem(
                    icon: Icons.shopping_bag_outlined,
                    title: t.my_orders,
                    onTap: () {
                      MyNavigator.goTo(context, MyOrderView(),
                          type: NavigatorType.push);
                    },
                  ),
                  ProfileItem(
                    icon: Icons.favorite_border,
                    title: t.my_favorites,
                    onTap: () {},
                  ),
                  ProfileItem(
                    icon: Icons.settings_outlined,
                    title: t.settings,
                    onTap: () {
                      MyNavigator.goTo(
                        context,
                        SettingView(),
                        type: NavigatorType.push,
                      );
                    },
                  ),

                  SizedBox(height: 16.h),

                  /// Divider
                  Container(
                    width: double.infinity,
                    height: 1.5.h,
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    color: AppColors.primary.withOpacity(0.3),
                  ),

                  SizedBox(height: 8.h),

                  /// Log out
                  ProfileItem(
                    icon: Icons.logout,
                    title: t.logout,
                    titleColor: AppColors.black,
                    onTap: _onLogoutPressed,
                  ),

                  SizedBox(height: 24.h),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
