import 'package:foodapp/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'device_model.g.dart';

@JsonSerializable()
class DeviceModel {
  ControlModelResp? control;
  double? doamdat;
  double? hum;
  double? light;
  double? ph;
  double? temp;
  double? rain;
  DeviceModel({
    this.control,
    this.doamdat,
    this.hum,
    this.light,
    this.ph,
    this.temp,
    this.rain,
  });
  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceModelToJson(this);
}
