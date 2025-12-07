import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stylish/core/utiles/app_icons.dart';
import 'package:stylish/core/utiles/app_textstyle.dart';
import 'package:stylish/core/widgets/custom_buttom.dart';
import 'package:stylish/core/widgets/custom_svg.dart';
import 'package:stylish/featuers/login/manager/login_cubit.dart';
import 'package:stylish/featuers/login/manager/login_states.dart';
import 'package:stylish/featuers/main_layout/views/main_layout_view.dart';
import '../../../core/helper/app_toast.dart';
import '../../../core/helper/my_navgitor.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_textformfailed.dart';
import '../../../core/widgets/image_manager/cubit/image_manager_cubit.dart';
class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: '',
        ),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            final cubit = LoginCubit.get(context);

            if (state is LoginSuccess) {
              cubit.clearControllers();
              ImageManagerCubit.get(context).clearImage();

              MyNavigator.goTo(
                context,
                MainLayout(user: state.userModel),
                type: NavigatorType.pushAndRemoveUntil,
              );
            } else if (state is LoginError) {
              cubit.clearControllers();
              ImageManagerCubit.get(context).clearImage();
              AppToast.error(context, state.error);
            }
          },
          builder: (context, state) {
            final cubit = LoginCubit.get(context);

            return Form(
              key: cubit.formkay,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),

                      /// Title
                      Text(
                        t.login_title, // "Welcome\nBack!"
                        style: AppTextStyles.monstrat24smibold800.copyWith(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),

                      SizedBox(height: 45.h),

                      /// Email
                      CustomTextformfaild(
                        controller: cubit.emailController,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        hintText: t.email,
                        prefixIcon: IconButton(
                          onPressed: null,
                          icon: CustomSvg(path: AppIcons.emailIcon),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      /// Password
                      CustomTextformfaild(
                        obscureText: cubit.isPassword,
                        controller: cubit.passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: t.password,
                        prefixIcon: IconButton(
                          onPressed: null,
                          icon: CustomSvg(path: AppIcons.lockicon),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            cubit.changePasswordVisibility();
                          },
                          icon: CustomSvg(
                            path: cubit.isPassword
                                ? AppIcons.eye
                                : AppIcons.eyeclose,
                          ),
                        ),
                      ),

                      SizedBox(height: 56.h),

                      /// Button / Loading
                      state is LoginLoading
                          ? SizedBox(
                        width: double.infinity,
                        height: 55.h,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: SizedBox(
                            width: 28.w,
                            height: 28.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                          : CustomButton(
                        text: t.login,
                        onPressed: () {
                          cubit.onLoginPressed();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
