import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import '../Model/image_model.dart';

class ImageDatabase {
  static final ImageDatabase instance = ImageDatabase._init();

  ImageDatabase._init();

  static Database? _database;

  Future<File?> pickImage(ImageSource imageSource) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }

    return null;
  }
}
