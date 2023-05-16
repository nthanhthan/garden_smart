

import 'package:foodapp/app/core.dart';

class SubjectKeyrManager {
  SubjectKeyCacheService subjectKeyCacheService;

  SubjectKeyrManager({required this.subjectKeyCacheService});

  Future<bool> initSession() async {
    await subjectKeyCacheService.init();
    return true;
  }

  SubjectKeyConfig? getSubjectKeys() {
    var data = subjectKeyCacheService.repo.getAllValues();
    if (data.isEmpty) return null;
    return data.values.first;
  }

  Future<void> saveSubjectKey(SubjectKeyConfig? subjectKey) async {
    if (subjectKey == null) return;
    await subjectKeyCacheService.repo.putAndUpdateExisting(
      AppKeys.chapterKey,
      subjectKey,
      (key, mutateMe, newValueReadOnly) {
        return newValueReadOnly;
      },
    );
  }
}
