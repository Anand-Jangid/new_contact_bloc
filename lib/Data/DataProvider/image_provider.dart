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

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'my_database.db');
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE images (id INTEGER PRIMARY KEY, imagePath TEXT)',
        );
      },
    );
    return database;
  }

  Future<int> insertImage(ImageModel imageModel) async {
    final db = await database;
    final result = await db.insert('images', imageModel.toMap());
    print("-------------result: ${result} --------------");
    return result;
  }

  Future<List<ImageModel>> getImages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('images');
    return List.generate(maps.length, (i) {
      return ImageModel.fromMap(maps[i]);
    });
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
