// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'control_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ControlModelResp _$ControlModelRespFromJson(Map<String, dynamic> json) =>
    ControlModelResp(
      auto: json['auto'] as bool?,
      fan: json['fan'] as bool?,
      light: json['light'] as bool?,
      pump: json['pump'] as bool?,
    );

Map<String, dynamic> _$ControlModelRespToJson(ControlModelResp instance) =>
    <String, dynamic>{
      'auto': instance.auto,
      'fan': instance.fan,
      'light': instance.light,
      'pump': instance.pump,
    };
