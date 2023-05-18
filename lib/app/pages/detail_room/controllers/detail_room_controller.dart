import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:foodapp/app/core.dart';

class DetailRoomController extends GetxController {
  final RxBool _switchVoice = true.obs;
  set switchVoice(bool value) => _switchVoice.value = value;
  bool get switchVoice => _switchVoice.value;
  late ControlModelResp controlModelResp;

  Rx<DeviceModel?> temp = DeviceModel().obs;
  Rx<DeviceModel?> doamdat = DeviceModel().obs;
  Rx<DeviceModel?> hum = DeviceModel().obs;
  Rx<DeviceModel?> light = DeviceModel().obs;
  Rx<DeviceModel?> ph = DeviceModel().obs;

  RxList<ControlModel> listControl = <ControlModel>[].obs;
  Future<void> switchVoiceOnClicked(
      bool value, ControlModel controlModel) async {
    ControlModel control = listControl.firstWhere(
      (element) => element.index == controlModel.index,
    );
    control.value = value;
    updateControl(control.index, value);
    listControl.refresh();
  }

  int? index;
  String? room;

  @override
  Future<void> onInit() async {
    if (Get.arguments != null && Get.arguments is int) {
      index = Get.arguments as int;
      if (index == 0) {
        room = "KHU_1";
      } else {
        room = "KHU_2";
      }
    }
    initTemp();
    initHum();
    initDoamdat();
    initLight();
    initPH();
    initControl();
    super.onInit();
  }

  void initControl() {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('$room/control');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      try {
        final Map<String, dynamic> value = jsonDecode(jsonEncode(data));
        controlModelResp = ControlModelResp.fromJson(value);
        ControlModel auto = ControlModel(
          index: 0,
          value: controlModelResp.auto ?? false,
          name: S.current.auto,
        );
        ControlModel fan = ControlModel(
          index: 1,
          value: controlModelResp.fan ?? false,
          name: S.current.fan,
        );
        ControlModel pump = ControlModel(
          index: 2,
          value: controlModelResp.pump ?? false,
          name: S.current.pump,
        );
        ControlModel light = ControlModel(
          index: 3,
          value: controlModelResp.light ?? false,
          name: S.current.light,
        );
        listControl.clear();
        listControl.addAll([auto, fan, pump, light]);
        // ignore: empty_catches
      } catch (e) {}
    });
  }

  void initTemp() {
    DatabaseReference dataRoom = FirebaseDatabase.instance.ref('$room/temp');
    LogUtil.d('$room/temp');
    dataRoom.onValue.listen((event) {
      final data = event.snapshot.value;
      try {
        final Map<String, dynamic> valueDevice = jsonDecode(jsonEncode(data));
        temp.value = DeviceModel.fromJson(valueDevice.values.last);
        LogUtil.d(temp.value?.value ?? "loi");

        // ignore: empty_catches
      } catch (e) {
        LogUtil.d(data.toString());
      }
    });
  }

  void initDoamdat() {
    DatabaseReference dataRoom = FirebaseDatabase.instance.ref('$room/doamdat');
    LogUtil.d('$room/doamdat');
    dataRoom.onValue.listen((event) {
      final data = event.snapshot.value;
      try {
        final Map<String, dynamic> valueDevice = jsonDecode(jsonEncode(data));
        doamdat.value = DeviceModel.fromJson(valueDevice.values.last);
        if (doamdat.value != null && doamdat.value!.value != null) {
          doamdat.value?.value = doamdat.value!.value! / 100;
        }
        LogUtil.d(doamdat.value?.value ?? "loi");

        // ignore: empty_catches
      } catch (e) {
        LogUtil.d(data.toString());
      }
    });
  }

  void initHum() {
    DatabaseReference dataRoom = FirebaseDatabase.instance.ref('$room/hum');
    LogUtil.d('$room/hum');
    dataRoom.onValue.listen((event) {
      final data = event.snapshot.value;
      try {
        final Map<String, dynamic> valueDevice = jsonDecode(jsonEncode(data));
        hum.value = DeviceModel.fromJson(valueDevice.values.last);
        if (hum.value != null && hum.value!.value != null) {
          hum.value?.value = hum.value!.value! / 100;
        }
        LogUtil.d(hum.value?.value ?? "loi");

        // ignore: empty_catches
      } catch (e) {
        LogUtil.d(data.toString());
      }
    });
  }

  void initLight() {
    DatabaseReference dataRoom = FirebaseDatabase.instance.ref('$room/light');
    LogUtil.d('$room/light');
    dataRoom.onValue.listen((event) {
      final data = event.snapshot.value;
      try {
        final Map<String, dynamic> valueDevice = jsonDecode(jsonEncode(data));
        light.value = DeviceModel.fromJson(valueDevice.values.last);
        LogUtil.d(light.value?.value ?? "loi");

        // ignore: empty_catches
      } catch (e) {
        LogUtil.d(data.toString());
      }
    });
  }

  void initPH() {
    DatabaseReference dataRoom = FirebaseDatabase.instance.ref('$room/ph');
    LogUtil.d('$room/ph');
    dataRoom.onValue.listen((event) {
      final data = event.snapshot.value;
      try {
        final Map<String, dynamic> valueDevice = jsonDecode(jsonEncode(data));
        ph.value = DeviceModel.fromJson(valueDevice.values.last);
        LogUtil.d(ph.value?.value ?? "loi");

        // ignore: empty_catches
      } catch (e) {
        LogUtil.d(data.toString());
      }
    });
  }

  void updateControl(int index, bool value) {
    String key = "";
    switch (index) {
      case 0:
        key = "auto";
        break;
      case 1:
        key = "fan";
        break;
      case 2:
        key = "pump";
        break;
      case 3:
        key = "light";
        break;
    }
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('$room/control');
    starCountRef.update({key: value});
  }
}
