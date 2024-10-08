import 'dart:io';
import 'dart:ui' as ui;

class DeviceUtil {
  static double devicePixelRatio = ui.window.devicePixelRatio;
  static ui.Size size = ui.window.physicalSize;
  static double width = size.width;
  static double height = size.height;
  static double screenWidth = width / devicePixelRatio;
  static double screenHeight = height / devicePixelRatio;
  static ui.Size screenSize = ui.Size(screenWidth, screenHeight);
  late final bool isTablet, isPhone, isIos, isAndroid, isIphoneX;
  static late DeviceUtil? _device;

  DeviceUtil({this.isTablet = false, this.isPhone = false, this.isIos = false, this.isAndroid = false, this.isIphoneX = false});

  factory DeviceUtil.get() {
    if (_device != null) {
      return _device!;
    }

    bool isTablet;
    bool isPhone;
    bool isIos = Platform.isIOS;
    bool isAndroid = Platform.isAndroid;
    bool isIphoneX = false;

    if (devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) {
      isTablet = true;
      isPhone = false;
    } else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      isTablet = true;
      isPhone = false;
    } else {
      isTablet = false;
      isPhone = true;
    }

    if (isIos && (screenHeight == 812 || screenWidth == 812 || screenHeight == 896 || screenWidth == 896)) {
      isIphoneX = true;
    }

    return _device = DeviceUtil(isTablet: isTablet, isPhone: isPhone, isAndroid: isAndroid, isIos: isIos, isIphoneX: isIphoneX);
  }
}
