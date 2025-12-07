import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stylish/core/helper/app_toast.dart';
import 'package:stylish/core/helper/app_validator.dart';
import 'package:stylish/featuers/register/views/widegts/custom_auth_image.dart';
import '../../../core/helper/my_navgitor.dart';
import '../../../core/utiles/app_icons.dart';
import '../../../core/utiles/app_textstyle.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../../core/widgets/custom_svg.dart';
import '../../../core/widgets/custom_textformfailed.dart';
import '../../../core/widgets/image_manager/cubit/image_manager_cubit.dart';
import '../../../core/widgets/image_manager/image_manager_view.dart';
import '../../login/views/login_view.dart';
import '../manager/register_cubit.dart';
import '../manager/register_states.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!; // ← ده بدل .tr()

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        appBar: const CustomAppBar(title: ''),
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            final cubit = RegisterCubit.get(context);

            if (state is RegisterSuccess) {
              AppToast.success(context, state.response.message);
              cubit.clearControllers();
              ImageManagerCubit.get(context).clearImage();
              MyNavigator.goTo(
                context,
                const LoginView(),
                type: NavigatorType.push,
              );
            } else if (state is RegisterError) {
              AppToast.error(context, state.error);
              cubit.clearControllers();
              ImageManagerCubit.get(context).clearImage();
            }
          },
          builder: (context, state) {
            final cubit = RegisterCubit.get(context);

            return Form(
              key: cubit.formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),

                      /// ------------------- Title + Image Picker -------------------
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              t.register_title, // "Create an\naccount"
                              style: AppTextStyles.monstrat24smibold800
                                  .copyWith(
                                fontSize: 36.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          ImageManagerView(
                            onImagePicked: (image) =>
                            RegisterCubit.get(context).image = image,
                            imageBuilder: (pickedImage) {
                              return CustomAuthImage(
                                image: FileImage(File(pickedImage.path)),
                              );
                            },
                            defaultBuilder: const CustomAuthImage(),
                          ),
                        ],
                      ),

                      SizedBox(height: 45.h),

                      /// ------------------- Full Name -------------------
                      CustomTextformfaild(
                        controller: cubit.nameController,
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        hintText: t.full_name,
                        prefixIcon: IconButton(
                          onPressed: null,
                          icon: CustomSvg(path: AppIcons.User),
                        ),
                        validator: AppValidator.requiredValidator,
                      ),

                      SizedBox(height: 16.h),

                      /// ------------------- Phone Number -------------------
                      CustomTextformfaild(
                        controller: cubit.phoneController,
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        hintText: t.phone_number,
                        prefixIcon: IconButton(
                          onPressed: null,
                          icon: CustomSvg(path: AppIcons.callIcon),
                        ),
                        validator: AppValidator.phoneValidator,
                      ),

                      SizedBox(height: 16.h),

                      /// ------------------- Email -------------------
                      CustomTextformfaild(
                        controller: cubit.emailController,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        hintText: t.email,
                        prefixIcon: IconButton(
                          onPressed: null,
                          icon: CustomSvg(path: AppIcons.emailIcon),
                        ),
                        validator: AppValidator.emailValidator,
                      ),

                      SizedBox(height: 16.h),

                      /// ------------------- Password -------------------
                      CustomTextformfaild(
                        controller: cubit.passwordController,
                        obscureText: cubit.isPassword,
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
                            width: 17.w,
                            height: 17.h,
                            path: cubit.isPassword
                                ? AppIcons.eye
                                : AppIcons.eyeclose,
                          ),
                        ),
                        validator: AppValidator.passwordValidator,
                      ),

                      SizedBox(height: 16.h),

                      /// ------------------- Confirm Password -------------------
                      CustomTextformfaild(
                        controller: cubit.confirmPasswordController,
                        obscureText: cubit.isConfirmPassword,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: t.confirm_password,
                        prefixIcon: IconButton(
                          onPressed: null,
                          icon: CustomSvg(path: AppIcons.lockicon),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            cubit.changeConfirmPasswordVisibility();
                          },
                          icon: CustomSvg(
                            width: 17.w,
                            height: 17.h,
                            path: cubit.isConfirmPassword
                                ? AppIcons.eye
                                : AppIcons.eyeclose,
                          ),
                        ),
                        validator: (value) {
                          return AppValidator.confirmPasswordValidator(
                            value,
                            cubit.passwordController.text,
                          );
                        },
                      ),

                      SizedBox(height: 21.h),

                      /// ------------------- Terms Text -------------------
                      Text(
                        t.agree_terms,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff676767),
                        ),
                      ),

                      SizedBox(height: 28.h),

                      /// ------------------- Create Account Button -------------------
                      state is RegisterLoading
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
                        text: t.create_account,
                        onPressed: () {
                          cubit.onRegisterPressed();
                        },
                      ),

                      SizedBox(height: 20.h),
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
