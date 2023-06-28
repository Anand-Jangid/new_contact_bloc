// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageModelHiveAdapter extends TypeAdapter<ImageModelHive> {
  @override
  final int typeId = 2;

  @override
  ImageModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageModelHive(
      contactId: fields[0] as int,
      images: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ImageModelHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.contactId)
      ..writeByte(1)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
