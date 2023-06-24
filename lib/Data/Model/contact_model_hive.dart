import 'package:hive/hive.dart';

part 'contact_model_hive.g.dart';

@HiveType(typeId: 1)
class ContactModelHive {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String phoneNumber;

  @HiveField(4)
  final int isFavourite;

  @HiveField(5)
  final DateTime createdTime;

  @HiveField(6)
  final DateTime updatedTime;

  ContactModelHive({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.isFavourite,
    required this.createdTime,
    required this.updatedTime,
  });
}
