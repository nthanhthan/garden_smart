// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_key_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectKeyConfigAdapter extends TypeAdapter<SubjectKeyConfig> {
  @override
  final int typeId = 4;

  @override
  SubjectKeyConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectKeyConfig(
      subjects: (fields[0] as List?)?.cast<SubjectKeyModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, SubjectKeyConfig obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.subjects);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectKeyConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectKeyConfig _$SubjectKeyConfigFromJson(Map<String, dynamic> json) =>
    SubjectKeyConfig(
      subjects: (json['subjects'] as List<dynamic>?)
          ?.map((e) => SubjectKeyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubjectKeyConfigToJson(SubjectKeyConfig instance) =>
    <String, dynamic>{
      'subjects': instance.subjects,
    };
