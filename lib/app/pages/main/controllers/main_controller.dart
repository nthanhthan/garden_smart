import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../../core.dart';

class MainController extends GetxController {
  static MainController get to => Get.find();

  late ChapterManager _chapterManager;
  late SubjectKeyrManager _subjectKeyrManager;
  @override
  void onInit() {
    _chapterManager = Get.find<ChapterManager>();
    _subjectKeyrManager = Get.find<SubjectKeyrManager>();
    ConfigDataService().initializeConfigRemote().then((value) {
      appInitializer();
    });
    super.onInit();
  }

  @override
  void onClose() async {
    await HiveManager.close();
    super.onClose();
  }

  Future<void> appInitializer() async {
    await Prefs.load();
    DioClient.clearInterceptors(DioClient.currentDio());
    trackAuth();

    // DioClient.setInterceptorRetry(DioClient.currentDio());
    if (BuildConfig().isDebug) {
      DioClient.setInterceptorLogger(
        DioClient.currentDio(),
        printOnSuccess: true,
      );
    }

    //client service
    DioClient.onErrorHandle = AppApiError.errorMessageHandle;
    DioClient.updateBaseUrl(
      DioClient.currentDio(),
      Uri.parse(BuildConfig().env.baseApi),
    );
    DioClient.updateTimeOut(
      DioClient.currentDio(),
      connectTimeOut: 30 * 1000,
      receiveTimeout: 30 * 1000,
    );
    //Init Hive
    await HiveManager.init();
    _subjectKeyrManager.initSession();
    _chapterManager.initSession();
    //Set Language
    String lang = Prefs.getString(AppKeys.languageKey, defaultValue: "en_US");
    await MyApp.of(Get.context!)?.changeLanguage(lang);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    try {
      final data = ConfigDataService().getRemoteConfigSubjectkey();
      final result =
          SubjectKeyConfig.fromJson(jsonDecode(data) as Map<String, dynamic>);
      _subjectKeyrManager.saveSubjectKey(result);
      // ignore: empty_catches
    } catch (e) {}

    //Delay for show Splash screen
    await Future.delayed(const Duration(seconds: 2), () {
      String user = Prefs.getString("user_id");
      if (user.isNotEmpty) {
        Get.offNamed(Routes.home);
      } else {
        Get.offNamed(Routes.signIn);
      }
    });
  }

  void trackAuth() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        Prefs.saveString('user_id', user.uid);
      } else {
        Prefs.removeKey('user_id');
      }
    });
  }
}
