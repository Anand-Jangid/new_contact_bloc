import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class ImageDatabase {
  static final ImageDatabase instance = ImageDatabase._init();

  ImageDatabase._init();

  Future<String?> getImageString(ImageSource imageSource) async {
    final File? pickedImage = await pickImage(imageSource);
    if (pickedImage != null) {
      final String fileName = basename(pickedImage.path);
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String imagePath = '${appDir.path}/$fileName';
      return imagePath;
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
