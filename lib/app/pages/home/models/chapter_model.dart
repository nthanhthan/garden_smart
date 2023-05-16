import 'package:foodapp/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chapter_model.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.chapter)
class ChapterModel {
  @HiveField(0)
  String? nameChapter;
  @HiveField(1)
  List<QuestionModel>? questions;
  ChapterModel({this.nameChapter, this.questions});
  
  factory ChapterModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterModelToJson(this);
}
