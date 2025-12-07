import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylish/featuers/register/manager/register_states.dart';
import '../data/register_repo.dart';
class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit():super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  bool isConfirmPassword = true;
  XFile? image;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    emit(RegisterChangePasswordVisibility());
  }

  void changeConfirmPasswordVisibility()
  {
    isConfirmPassword = !isConfirmPassword;
    emit(RegisterChangeConfirmPasswordVisibility());
  }

  void onRegisterPressed()async
  {
    if( !formKey.currentState!.validate()){
      return;
    }
    emit(RegisterLoading());
    RegisterRepo registerRepo = RegisterRepo();
    var response = await registerRepo.register(
        phone: phoneController.text,
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        image: image
    );
    response.fold(
        (String error) => emit(RegisterError(error: error)),
        (response) => emit(RegisterSuccess(response: response))
    );

  }
  void clearControllers()
  {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    image = null;
  }
}



