import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:foodapp/app/core.dart';

class DetailRoomController extends GetxController {
  final RxBool _switchVoice = true.obs;
  set switchVoice(bool value) => _switchVoice.value = value;
  bool get switchVoice => _switchVoice.value;
  final Rx<DeviceModel> _controlModelResp = DeviceModel().obs;
  set controlModelResp(DeviceModel value) => _controlModelResp.value = value;
  DeviceModel get controlModelResp => _controlModelResp.value;

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
    super.onInit();
  }

  @override
  void onReady() {
    initControl();
    super.onReady();
  }

  void initControl() {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('$room');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      try {
        final Map<String, dynamic> value = jsonDecode(jsonEncode(data));
        controlModelResp = DeviceModel.fromJson(value);
        if (controlModelResp.hum != null) {
          controlModelResp.hum = controlModelResp.hum! / 100;
        }
        if (controlModelResp.doamdat != null) {
          controlModelResp.doamdat = controlModelResp.doamdat! / 100;
        }
        if (controlModelResp.rain != null) {
          controlModelResp.rain = controlModelResp.rain! / 100;
        }
        ControlModel auto = ControlModel(
          index: 0,
          value: controlModelResp.control?.auto ?? false,
          name: S.current.auto,
        );
        ControlModel fan = ControlModel(
          index: 1,
          value: controlModelResp.control?.fan ?? false,
          name: S.current.fan,
        );
        ControlModel pump = ControlModel(
          index: 2,
          value: controlModelResp.control?.pump ?? false,
          name: S.current.pump,
        );
        ControlModel light = ControlModel(
          index: 3,
          value: controlModelResp.control?.light ?? false,
          name: S.current.light,
        );
        ControlModel curtain = ControlModel(
          index: 4,
          value: controlModelResp.control?.curtain ?? false,
          name: S.current.curtain,
        );
        listControl.clear();
        listControl.addAll([
          auto,
          fan,
          pump,
          light,
          curtain,
        ]);
        // ignore: empty_catches
      } catch (e) {}
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
      case 4:
        key = "curtain";
        break;
    }
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('$room/control');
    starCountRef.update({key: value});
  }
}
