import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stylish/core/helper/app_toast.dart';
import 'package:stylish/core/widgets/custom_appbar.dart';
import 'package:stylish/featuers/login/data/model/login_response_model.dart';
import 'package:stylish/featuers/main_layout/manager/user_cubit.dart';

import '../../../core/helper/app_validator.dart';
import '../../../core/utiles/app_icons.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../../core/widgets/custom_svg.dart';
import '../../../core/widgets/custom_textformfailed.dart';
import '../../../core/widgets/image_manager/image_manager_view.dart';
import '../../register/views/widegts/custom_auth_image.dart';
import '../manager/update_profile_cubit.dart';
import '../manager/update_profile_states.dart';

class UpdateProfileView extends StatelessWidget {
  const UpdateProfileView({super.key, this.userModel});
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => UpdateProfileCubit(userModel: userModel),
      child: Scaffold(
        appBar: CustomAppBar(title: t.update_profile),
        body: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
          listener: (context, state) async {
            if (state is UpdateProfileSuccess) {
              // نحدّث بيانات اليوزر في UserCubit عشان ترجع تسمع في البروفايل
              await UserCubit.get(context).getUser();
              AppToast.success(context, state.message);
              Navigator.pop(context);
            }
            if (state is UpdateProfileFailure) {
              AppToast.error(context, state.message);
            }
          },
          builder: (context, state) {
            final cubit = UpdateProfileCubit.get(context);

            return Form(
              key: cubit.formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 24.h),
                      Center(
                        child: ImageManagerView(
                          onImagePicked: (image) => cubit.image = image,
                          imageBuilder: (pickedImage) {
                            return CustomAuthImage(
                              image: FileImage(File(pickedImage.path)),
                            );
                          },
                          defaultBuilder:
                          (userModel?.imagePath != null &&
                              userModel!.imagePath!.isNotEmpty)
                              ? CustomAuthImage(
                            image: NetworkImage(
                              userModel!.imagePath!,
                            ),
                          )
                              : const CustomAuthImage(),
                        ),
                      ),
                      SizedBox(height: 66.h),
                      CustomTextformfaild(
                        controller: cubit.nameController,
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        hintText: t.full_name,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: CustomSvg(path: AppIcons.User),
                        ),
                        validator: AppValidator.requiredValidator,
                      ),
                      SizedBox(height: 23.h),
                      CustomTextformfaild(
                        controller: cubit.phoneController,
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        hintText: t.phone_number,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: CustomSvg(path: AppIcons.callIcon),
                        ),
                        validator: AppValidator.phoneValidator,
                      ),
                      SizedBox(height: 28.h),
                      state is UpdateProfileLoading
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
                        text: t.update_profile,
                        onPressed: () {
                          cubit.updateProfile();
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
