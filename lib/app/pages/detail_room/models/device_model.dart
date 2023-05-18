import 'package:json_annotation/json_annotation.dart';
part 'device_model.g.dart';

@JsonSerializable()
class DeviceModel {
  String? time;
  double? value;
  DeviceModel({this.time, this.value});
   factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceModelToJson(this);
}
