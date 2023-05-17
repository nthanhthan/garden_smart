import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodapp/app/core.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin, WidgetsBindingObserver {
  GlobalKey<ScaffoldState> keyChapter = GlobalKey();
  late ChapterManager _chapterManager;

  SubjectModel? subjectModel;
  final RxList<QuestionModel> _listQuestion = RxList<QuestionModel>();
  // ignore: invalid_use_of_protected_member
  List<QuestionModel> get listQuestions => _listQuestion.value;
  set listQuestions(List<QuestionModel> value) => _listQuestion.value = value;

  final RxString _nameChapterClicked = "".obs;
  String get getNameChapter => _nameChapterClicked.value;
  set nameChapter(String value) => _nameChapterClicked.value = value;

  final Rx<List<bool>> _isExpandedList = Rx<List<bool>>([]);
  // ignore: invalid_use_of_protected_member
  List<bool> get expandedList => _isExpandedList.value;
  set expandedList(List<bool> value) => _isExpandedList.value = value;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String key = "";

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    if (Get.arguments != null && Get.arguments is String) {
      key = Get.arguments as String;
    }
    _chapterManager = Get.find<ChapterManager>();
    subjectModel = _chapterManager.getChapters(key);
    if (subjectModel != null &&
        subjectModel!.chapters != null &&
        subjectModel!.chapters!.isNotEmpty) {
      listQuestions = subjectModel!.chapters!.first.questions!;
      expandedList =
          List<bool>.generate(listQuestions.length, (index) => false);
      nameChapter = subjectModel!.chapters!.first.nameChapter!;
    }
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      LogUtil.d('Home: on app ressume!');
    }
  }

  void chapterClick(ChapterModel chapter) {
    listQuestions = chapter.questions ?? [];
    nameChapter = chapter.nameChapter ?? "";
    expandedList = List<bool>.generate(listQuestions.length, (index) => false);
    _isExpandedList.refresh();
  }

  void changeExpansion(int index, bool value) {
    expandedList[index] = value;
    _isExpandedList.refresh();
  }

  void logoutClick() {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    _auth.signOut().then((value) {
      processingDialog.hide();
      Get.offAllNamed(Routes.signIn);
    });
  }

  void roomClick(int index) {
    Get.toNamed(
      Routes.detailRoom,
      arguments: index,
    );
  }
}
