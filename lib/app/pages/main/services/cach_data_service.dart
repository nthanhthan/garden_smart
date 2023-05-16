import 'package:foodapp/app/core.dart';

class ChapterCacheService extends CacheServiceInterface {
  final repo = ChapterRepo();
  @override
  Future<void> initRepos() async {
    if (!Hive.isBoxOpen(ModelTypeDefine.subjectbox)) {
      await Hive.openBox<SubjectModel>(ModelTypeDefine.subjectbox);
    }
    await repo.init();
  }

  @override
  void registerTypeAdapters() {
     
    if (!Hive.isAdapterRegistered(ModelTypeDefine.question)) {
      Hive.registerAdapter<QuestionModel>(QuestionModelAdapter());
    }
   
    if (!Hive.isAdapterRegistered(ModelTypeDefine.chapter)) {
      Hive.registerAdapter<ChapterModel>(ChapterModelAdapter());
    }
     if (!Hive.isAdapterRegistered(ModelTypeDefine.subject)) {
      Hive.registerAdapter<SubjectModel>(SubjectModelAdapter());
    }
  }

  @override
  Future<void> dispose() async {
    await repo.dispose();
    return super.dispose();
  }
}
