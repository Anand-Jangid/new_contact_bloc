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
      name: fields[1] as String,
      email: fields[2] as String,
      phoneNumber: fields[3] as String,
      isFavourite: fields[4] as int,
      createdTime: fields[5] as DateTime,
      updatedTime: fields[6] as DateTime,
    )..id = fields[0] as int?;
  }

  @override
  void write(BinaryWriter writer, ContactModelHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phoneNumber)
      ..writeByte(4)
      ..write(obj.isFavourite)
      ..writeByte(5)
      ..write(obj.createdTime)
      ..writeByte(6)
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
