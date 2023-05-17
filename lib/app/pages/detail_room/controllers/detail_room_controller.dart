import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:foodapp/app/core.dart';

class DetailRoomController extends GetxController {
  final RxBool _switchVoice = true.obs;
  set switchVoice(bool value) => _switchVoice.value = value;
  bool get switchVoice => _switchVoice.value;
  late ControlModelResp controlModelResp;

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
      }else{
         room = "KHU_2";
      }
    }
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
