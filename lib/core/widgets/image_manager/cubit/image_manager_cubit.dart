import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'image_manager_state.dart';

class ImageManagerCubit extends Cubit<ImageManagerState> {
  ImageManagerCubit() : super(ImageManagerInitial());

  static ImageManagerCubit get(context) => BlocProvider.of(context);

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(ImageManagerPicked(image));
    }
  }

  void clearImage() {
    emit(ImageManagerInitial());
  }
}
