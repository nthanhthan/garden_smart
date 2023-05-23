import 'package:json_annotation/json_annotation.dart';
part 'control_resp.g.dart';

@JsonSerializable()
class ControlModelResp {
  bool? auto;
  bool? fan;
  bool? light;
  bool? pump;
  bool? curtain;
  ControlModelResp({
    this.auto,
    this.fan,
    this.light,
    this.pump,
    this.curtain,
  });
  factory ControlModelResp.fromJson(Map<String, dynamic> json) =>
      _$ControlModelRespFromJson(json);
  Map<String, dynamic> toJson() => _$ControlModelRespToJson(this);
}
