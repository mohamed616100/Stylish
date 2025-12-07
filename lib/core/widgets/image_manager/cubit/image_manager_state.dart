import 'package:image_picker/image_picker.dart';

abstract class ImageManagerState{}

class ImageManagerInitial extends ImageManagerState{}

class ImageManagerPicked extends ImageManagerState{
 final XFile image;
  ImageManagerPicked(this.image);
}