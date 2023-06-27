class ImageModel {
  int? id;
  String imagePath;

  ImageModel({this.id, required this.imagePath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
    };
  }

  static ImageModel fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'],
      imagePath: map['imagePath'],
    );
  }
}
