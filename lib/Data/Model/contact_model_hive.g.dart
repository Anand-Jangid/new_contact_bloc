// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactModelHiveAdapter extends TypeAdapter<ContactModelHive> {
  @override
  final int typeId = 1;

  @override
  ContactModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactModelHive(
      name: (fields[0] as List).cast<String>(),
      email: (fields[1] as List).cast<String>(),
      phoneNumber: (fields[2] as List).cast<String>(),
      isFavourite: (fields[3] as List).cast<int>(),
      createdTime: (fields[4] as List).cast<DateTime>(),
      updatedTime: (fields[5] as List).cast<DateTime>(),
    );
  }

  @override
  void write(BinaryWriter writer, ContactModelHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.isFavourite)
      ..writeByte(4)
      ..write(obj.createdTime)
      ..writeByte(5)
      ..write(obj.updatedTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
