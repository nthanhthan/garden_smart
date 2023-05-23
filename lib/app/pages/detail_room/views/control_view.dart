// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:foodapp/app/core.dart';

class ControlView extends GetView<DetailRoomController> {
  const ControlView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  void _switchVoiceOnClicked(bool value, ControlModel controlModel) {
    controller.switchVoiceOnClicked(value, controlModel);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        backgroundColor: AppColors.main.shade300,
        title: Text(controller.room ?? ""),
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(12.0),
          child: InkWell(
            onTap: () {
              Get.offNamed(Routes.detailRoom, arguments: controller.index);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 25,
              color: AppColors.grey.shade100,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.grey.shade200),
        child: Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: controller.listControl.value.asMap().entries.map((e) {
              return _itemControl(context, controller.listControl.value[e.key]);
            }).toList())),
      ),
    );
  }

  Widget _itemControl(BuildContext context, ControlModel control) {
    Color colorActive;
    Color bg;
    if (control.index == 0 || control.index == 4) {
      colorActive = AppColors.main.shade300;
      bg = AppColors.main.shade100;
    } else if (control.index == 1) {
      colorActive = AppColors.secondary.shade300;
      bg = AppColors.secondary.shade100;
    } else if (control.index == 2) {
      colorActive = AppColors.success;
      bg = AppColors.success.shade100;
    } else {
      colorActive = AppColors.warning;
      bg = AppColors.warning.shade100;
    }
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            control.name,
            style:
                AppTextStyles.heading2().copyWith(fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: FlutterSwitch(
                width: 80.0,
                height: 40.0,
                valueFontSize: 25.0,
                toggleSize: 35.0,
                borderRadius: 30.0,
                activeToggleColor: colorActive,
                activeColor: bg,
                inactiveToggleColor: AppColors.grey.shade300,
                value: control.value,
                onToggle: (value) {
                  _switchVoiceOnClicked(value, control);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
