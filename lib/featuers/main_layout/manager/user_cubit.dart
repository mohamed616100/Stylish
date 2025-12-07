import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/featuers/main_layout/manager/user_state.dart';
import '../../login/data/model/login_response_model.dart';
import '../data/repos/user_repo.dart';

class UserCubit extends Cubit<UserState>
{
  UserCubit(): super(UserInitial());
  static UserCubit get(context) => BlocProvider.of(context);

  void controlUser(UserModel? user)
  {
    if(user == null)
    {
      getUser();
    }
    else
    {
      emit(UserSuccess(user: user));
    }
  }
  getUser()async
  {
    UserRepo userRepo = UserRepo();
    emit(UserLoading());
    var response = await userRepo.getUser();
    response.fold(
            (error)=> emit(UserError(error: error)),
            (user) => emit(UserSuccess(user: user)));
  }

}
