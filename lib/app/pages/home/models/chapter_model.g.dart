// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChapterModelAdapter extends TypeAdapter<ChapterModel> {
  @override
  final int typeId = 2;

  @override
  ChapterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChapterModel(
      nameChapter: fields[0] as String?,
      questions: (fields[1] as List?)?.cast<QuestionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ChapterModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.nameChapter)
      ..writeByte(1)
      ..write(obj.questions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChapterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterModel _$ChapterModelFromJson(Map<String, dynamic> json) => ChapterModel(
      nameChapter: json['nameChapter'] as String?,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChapterModelToJson(ChapterModel instance) =>
    <String, dynamic>{
      'nameChapter': instance.nameChapter,
      'questions': instance.questions,
    };
