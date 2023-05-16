import 'package:json_annotation/json_annotation.dart';
import 'package:foodapp/app/core.dart';
part 'subject_key_model.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.subjectKeyModel)
class SubjectKeyModel {
  @HiveField(0)
  String? key;
  @HiveField(1)
  String? name;
  SubjectKeyModel({this.key, this.name});
  factory SubjectKeyModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectKeyModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectKeyModelToJson(this);
}
