import 'package:json_annotation/json_annotation.dart';
import 'package:foodapp/app/core.dart';
part 'subject_key_config.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.subjectKey)
class SubjectKeyConfig {
  @HiveField(0)
  List<SubjectKeyModel>? subjects;
  SubjectKeyConfig({this.subjects});
  factory SubjectKeyConfig.fromJson(Map<String, dynamic> json) =>
      _$SubjectKeyConfigFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectKeyConfigToJson(this);
}
