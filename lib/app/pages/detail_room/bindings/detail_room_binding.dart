import 'package:foodapp/app/core.dart';

class DetailRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailRoomController());
  }
}
