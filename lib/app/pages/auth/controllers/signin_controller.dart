import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/app/core.dart';

class SignInController extends GetxController {
  final loginFormGlobalKey = GlobalKey<FormState>();
  TextEditingController accountFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  FocusNode accountNode = FocusNode();
  final RxBool _enableSignInBtn = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get enableSignInBtn => _enableSignInBtn.value;

  set enableSignInBtn(bool value) => _enableSignInBtn.value = value;

  String get account => accountFieldController.text.trim();

  String get password => passwordFieldController.text.trim();

  String? accountValidation(String? value) {
    if (value != null && StringExtensions(value).isEmail()) {
      return null;
    } else {
      return S.current.invalidEmailAddress;
    }
  }

  @override
  void onInit() {
    accountNode.addListener(() {
      accountFieldController.text = accountFieldController.text.trim();
    });
    super.onInit();
  }

  String? passwordValidation(String? value) {
    if (value == null || value.length < 8) {
      return S.current.invalidPasswordLength;
    } else if (!StringExtensions(value).isLeastOneLetter()) {
      return S.current.invalidPasswordOneLetter;
    } else if (!StringExtensions(value).isLeastOneNumber()) {
      return S.current.invalidPasswordOneNumber;
    } else {
      return null;
    }
  }

  bool get isFormValided {
    if (account.isEmpty || password.isEmpty) {
      return false;
    } else {
      return loginFormGlobalKey.currentState?.validate() ?? false;
    }
  }

  void checkFormValidation() {
    if (isFormValided) {
      enableSignInBtn = true;
    } else {
      enableSignInBtn = false;
    }
  }

  Future<void> signIn() async {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    try {
      await _auth
          .signInWithEmailAndPassword(
        email: account,
        password: password,
      )
          .then((value) {
        processingDialog.hide();
        Get.offAllNamed(Routes.home);
      });
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      processingDialog.hide();
      accountNode.requestFocus();
      SnackBars.error(message: S.current.erEmailOrPasswordInvalid).show();
    } catch (e) {
      processingDialog.hide();
      accountNode.requestFocus();
      SnackBars.error(message: S.current.erEmailOrPasswordInvalid).show();
    }
  }
}
