import 'package:foodapp/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'question_model.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.question)
class QuestionModel {
  @HiveField(0)
  String? question;
  @HiveField(1)
  String? answer;
  QuestionModel({this.question, this.answer});
  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}
