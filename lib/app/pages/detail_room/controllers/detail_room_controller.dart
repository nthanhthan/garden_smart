import 'package:foodapp/app/core.dart';

class DetailRoomController extends GetxController {
  final RxBool _switchVoice = true.obs;
  set switchVoice(bool value) => _switchVoice.value = value;
  bool get switchVoice => _switchVoice.value;

  RxList<ControlModel> listControl = [
    ControlModel(
      index: 0,
      value: false,
      name: S.current.auto,
    ),
    ControlModel(
      index: 1,
      value: false,
      name: S.current.fan,
    ),
    ControlModel(
      index: 2,
      value: false,
      name: S.current.pump,
    ),
    ControlModel(
      index: 3,
      value: false,
      name: S.current.light,
    ),
  ].obs;
  Future<void> switchVoiceOnClicked(
      bool value, ControlModel controlModel) async {
    ControlModel control = listControl.firstWhere(
      (element) => element.index == controlModel.index,
    );
    control.value = value;
    LogUtil.d(listControl);
    listControl.refresh();
    Prefs.saveBool(AppKeys.voiceMode, switchVoice);
  }
}
