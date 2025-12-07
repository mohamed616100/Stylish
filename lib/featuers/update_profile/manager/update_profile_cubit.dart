import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylish/featuers/login/data/model/login_response_model.dart';

import 'update_profile_states.dart';
import '../data/repos/updata_profile_repo.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit({this.userModel})
      : _repo = UpdateProfileRepo(),
        super(UpdateProfileInitial()) {
    _initData();
  }

  static UpdateProfileCubit get(context) => BlocProvider.of(context);

  final UserModel? userModel;
  final UpdateProfileRepo _repo;

  XFile? image;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void _initData() {
    if (userModel != null) {
      nameController.text = userModel?.name ?? '';
      phoneController.text = userModel?.phone ?? '';
    }
  }

  Future<void> updateProfile() async {
    if (!formKey.currentState!.validate()) return;

    final newName = nameController.text.trim();
    final newPhone = phoneController.text.trim();

    final oldName = userModel?.name?.trim() ?? '';
    final oldPhone = userModel?.phone?.trim() ?? '';

    final bool hasChanges =
        newName != oldName || newPhone != oldPhone || image != null;

    if (!hasChanges) {
      emit(UpdateProfileFailure('مفيش أي حاجة اتغيرت علشان تتعدل'));
      return;
    }

    emit(UpdateProfileLoading());

    final result = await _repo.updateProfile(
      name: newName == oldName ? '' : newName,
      phone: newPhone == oldPhone ? '' : newPhone,
      image: image,
    );

    result.fold(
          (error) => emit(UpdateProfileFailure(error)),
          (response) => emit(UpdateProfileSuccess(response.message)),
    );
  }

}
