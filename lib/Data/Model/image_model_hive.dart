// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

// import 'contact_model.dart';

part 'image_model_hive.g.dart';

@HiveType(typeId: 2)
class ImageModelHive extends HiveObject {
  @HiveField(0)
  final int contactId;

  @HiveField(1)
  final List<String> images;
  
  
  ImageModelHive({
    required this.contactId,
    required this.images,
  });
}
