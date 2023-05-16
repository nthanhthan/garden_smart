import 'package:foodapp/app/core.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    var subjectKeyService = Get.put(SubjectKeyCacheService());
    Get.put(SubjectKeyrManager(subjectKeyCacheService: subjectKeyService));
    var chapterCacheService = Get.put(ChapterCacheService());
    Get.put(ChapterManager(chapterCacheService: chapterCacheService));
    Get.put(MainController());
  }
}
