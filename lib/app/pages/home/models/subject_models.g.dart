// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectModelAdapter extends TypeAdapter<SubjectModel> {
  @override
  final int typeId = 3;

  @override
  SubjectModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectModel(
      nameSubject: fields[0] as String?,
      chapters: (fields[1] as List?)?.cast<ChapterModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, SubjectModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.nameSubject)
      ..writeByte(1)
      ..write(obj.chapters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectModel _$SubjectModelFromJson(Map<String, dynamic> json) => SubjectModel(
      nameSubject: json['nameSubject'] as String?,
      chapters: (json['chapters'] as List<dynamic>?)
          ?.map((e) => ChapterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubjectModelToJson(SubjectModel instance) =>
    <String, dynamic>{
      'nameSubject': instance.nameSubject,
      'chapters': instance.chapters,
    };
