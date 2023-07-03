import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageDatabase {
  static final ImageDatabase instance = ImageDatabase._init();

  ImageDatabase._init();
  final picker = ImagePicker();

  Future<List<String>?> getImageString(ImageSource imageSource) async {
    if (imageSource == ImageSource.camera) {
      final File? pickedImageFromCamera = await pickImageFromCamera();
      return [pickedImageFromCamera?.path ?? ''];
    } else {
      //pick from gallary
      final List<File>? pickedImagesFromGallary = await pickImageFromGallary();
      if (pickedImagesFromGallary != null) {
        List<String>? imagePaths = [];
        // pickedImagesFromGallary.map((imageFile) {
        //   imagePaths.add(imageFile.path);
        // });
        for (var pickedImage in pickedImagesFromGallary) {
          imagePaths.add(pickedImage.path);
        }
        return imagePaths;
      }
    }
    return null;
  }

  Future<File?> pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }

    return null;
  }

  Future<List<File>?> pickImageFromGallary() async {
    final pickedImages = await picker.pickMultiImage();
    List<File> pickedImagesFile = [];
    if (pickedImages != null) {
      for (var pickedImage in pickedImages) {
        pickedImagesFile.add(File(pickedImage.path));
      }
      return pickedImagesFile;
    }
    return null;
  }
}
