import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageDatabase {
  static final ImageDatabase instance = ImageDatabase._init();

  ImageDatabase._init();

  Future<String?> getImageString(ImageSource imageSource) async {
    final File? pickedImage = await pickImage(imageSource);
    if (pickedImage != null) {
      return pickedImage.path;
    }
    return null;
  }

  Future<File?> pickImage(ImageSource imageSource) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }

    return null;
  }
}
