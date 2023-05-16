import 'package:foodapp/app/core.dart';

class ChapterManager {
  ChapterCacheService chapterCacheService;

  ChapterManager({required this.chapterCacheService});

  Future<bool> initSession() async {
    await chapterCacheService.init();
    return true;
  }

  SubjectModel? getChapters(String key ) {
    var data = chapterCacheService.repo.getValueById(key);
    if (data==null) return null;
    return data;
  }

  Future<void> saveChapter(SubjectModel? chapter, String key) async {
    if (chapter == null) return;
  
    await chapterCacheService.repo.putAndUpdateExisting(
      key,
      chapter,
      (key, mutateMe, newValueReadOnly) {
        return newValueReadOnly;
      },
    );
  }

  // Future<void> deleteChapter() async {
  //   await chapterCacheService.repo.deleteKeys([AppKeys.chapterKey]);
  // }
}
