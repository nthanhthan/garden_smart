import 'package:foodapp/app/core.dart';

class SubjectHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SubjectHomeController>(SubjectHomeController());
  }
}
