

import '../data/model/login_response_model.dart';

abstract class LoginState {}
class InitialState extends LoginState{}
class ChangePasswordVisibilityState extends LoginState{}


class LoginLoading  extends LoginState{}
class LoginSuccess  extends LoginState
{
  final UserModel userModel;
  LoginSuccess({required this.userModel});
}
class LoginError extends LoginState
{
  final String error;
  LoginError({required this.error});
}