import '../../../core/network/api_response.dart';

abstract class RegisterState {}
class RegisterInitial extends RegisterState {}
class RegisterChangePasswordVisibility extends RegisterState {}
class RegisterChangeConfirmPasswordVisibility extends RegisterState {}
class RegisterLoading extends RegisterState {}
class RegisterSuccess extends RegisterState {
  final  ApiResponse response;
  RegisterSuccess({required this.response});
}
class RegisterError extends RegisterState {
  String error;
  RegisterError({required this.error});
}
