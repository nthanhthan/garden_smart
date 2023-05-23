// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceModel _$DeviceModelFromJson(Map<String, dynamic> json) => DeviceModel(
      control: json['control'] == null
          ? null
          : ControlModelResp.fromJson(json['control'] as Map<String, dynamic>),
      doamdat: (json['doamdat'] as num?)?.toDouble(),
      hum: (json['hum'] as num?)?.toDouble(),
      light: (json['light'] as num?)?.toDouble(),
      ph: (json['ph'] as num?)?.toDouble(),
      temp: (json['temp'] as num?)?.toDouble(),
      rain: (json['rain'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DeviceModelToJson(DeviceModel instance) =>
    <String, dynamic>{
      'control': instance.control,
      'doamdat': instance.doamdat,
      'hum': instance.hum,
      'light': instance.light,
      'ph': instance.ph,
      'temp': instance.temp,
      'rain': instance.rain,
    };
