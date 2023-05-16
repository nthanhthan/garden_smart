// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_key_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectKeyModelAdapter extends TypeAdapter<SubjectKeyModel> {
  @override
  final int typeId = 5;

  @override
  SubjectKeyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectKeyModel(
      key: fields[0] as String?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectKeyModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectKeyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectKeyModel _$SubjectKeyModelFromJson(Map<String, dynamic> json) =>
    SubjectKeyModel(
      key: json['key'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SubjectKeyModelToJson(SubjectKeyModel instance) =>
    <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
    };
