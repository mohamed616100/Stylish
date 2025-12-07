import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AddNumberState {}

class AddNumberInitil extends AddNumberState {
  final int value;
  AddNumberInitil({this.value = 1});
}

class AddNumberChanged extends AddNumberState {
  final int value;
  AddNumberChanged(this.value);
}

class AddNumberError extends AddNumberState {
  final String message;
  AddNumberError(this.message);
}

class AddNumberCubit extends Cubit<AddNumberState> {
  AddNumberCubit() : super(AddNumberInitil());

  static AddNumberCubit get(context) => BlocProvider.of(context);

  int number = 1;

  void increment({int? max}) {
    final next = number + 1;
    if (max != null && next > max) {
      emit(AddNumberError('Max reached'));
      return;
    }
    number = next;
    emit(AddNumberChanged(number));
  }

  void decrement({int min = 1}) {
    final next = number - 1;
    if (next < min) {
      number = min;
      emit(AddNumberChanged(number));
      return;
    }
    number = next;
    emit(AddNumberChanged(number));
  }

  void reset() {
    number = 1;
    emit(AddNumberChanged(number));
  }
}
