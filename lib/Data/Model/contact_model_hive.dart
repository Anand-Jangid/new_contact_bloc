// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import 'contact_model.dart';

part 'contact_model_hive.g.dart';

@HiveType(typeId: 1)
class ContactModelHive extends HiveObject {

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String phoneNumber;

  @HiveField(3)
  final int isFavourite;

  @HiveField(4)
  final DateTime createdTime;

  @HiveField(5)
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
