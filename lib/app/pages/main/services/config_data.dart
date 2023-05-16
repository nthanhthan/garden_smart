import 'package:firebase_remote_config/firebase_remote_config.dart';

class ConfigDataService {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initializeConfigRemote() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 0),
      ),
    );
    await remoteConfig.fetchAndActivate();
  }

  String getRemoteConfigSubjectkey() {
    return remoteConfig.getString('subjectKey');
  }
  String getChapterBySubject(String key){
 return remoteConfig.getString(key);
  }
}
