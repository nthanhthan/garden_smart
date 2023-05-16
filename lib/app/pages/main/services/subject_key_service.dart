import 'package:foodapp/app/core.dart';

class SubjectKeyCacheService extends CacheServiceInterface {
  final repo = SubjectKeyRepo();
  @override
  Future<void> initRepos() async {
    if (!Hive.isBoxOpen(ModelTypeDefine.subjectKeybox)) {
      await Hive.openBox<SubjectKeyConfig>(ModelTypeDefine.subjectKeybox);
    }
    await repo.init();
  }

  @override
  void registerTypeAdapters() {
    if (!Hive.isAdapterRegistered(ModelTypeDefine.subjectKeyModel)) {
      Hive.registerAdapter<SubjectKeyModel>(SubjectKeyModelAdapter());
    }
    if (!Hive.isAdapterRegistered(ModelTypeDefine.subjectKey)) {
      Hive.registerAdapter<SubjectKeyConfig>(SubjectKeyConfigAdapter());
    }
  }

  @override
  Future<void> dispose() async {
    await repo.dispose();
    return super.dispose();
  }
}
