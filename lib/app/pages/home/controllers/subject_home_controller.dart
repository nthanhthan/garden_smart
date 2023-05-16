import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodapp/app/core.dart';

class SubjectHomeController extends GetxController {
  late SubjectKeyrManager _subjectKeyrManager;
  SubjectKeyConfig? listSubject;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late ChapterManager _chapterManager;
  @override
  void onInit() {
    _subjectKeyrManager = Get.find<SubjectKeyrManager>();
    listSubject = _subjectKeyrManager.getSubjectKeys();
    _chapterManager = Get.find<ChapterManager>();
    super.onInit();
  }

  void logoutClick() {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    _auth.signOut().then((value) {
      processingDialog.hide();
      Get.offAllNamed(Routes.signIn);
    });
  }

  void subjectClick(SubjectKeyModel subjectModel) {
    try {
      final data =
          ConfigDataService().getChapterBySubject(subjectModel.key ?? "");
      final result =
          SubjectModel.fromJson(jsonDecode(data) as Map<String, dynamic>);
      // ignore: empty_catches
      _chapterManager.saveChapter(
        result,
        subjectModel.key ?? "",
      );
      Get.toNamed(
        Routes.home,
        arguments: subjectModel.key,
      );
      // ignore: empty_catches
    } catch (e) {
      SnackBars.complete(message: S.current.noData).show();
    }
  }
}
