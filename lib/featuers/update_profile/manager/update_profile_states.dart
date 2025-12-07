abstract class UpdateProfileState{}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileSuccess extends UpdateProfileState {
  final String message;
  UpdateProfileSuccess(this.message);
}

class UpdateProfileFailure extends UpdateProfileState {
  final String message;
  UpdateProfileFailure(this.message);

}
