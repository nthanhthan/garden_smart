import 'package:foodapp/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'subject_models.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.subject)
class SubjectModel {
  @HiveField(0)
  String? nameSubject;
  @HiveField(1)
  List<ChapterModel>? chapters;
  SubjectModel({this.nameSubject, this.chapters});
  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectModelToJson(this);
}
