import 'package:flutter/material.dart';
import 'package:foodapp/app/core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpController extends GetxController {
  final signUpFormGlobalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordAgainController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  FocusNode phoneNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final RxBool _enableSignUpBtn = false.obs;

  set enableSignUpBtn(bool value) => _enableSignUpBtn.value = value;

  bool get enableSignUpBtn => _enableSignUpBtn.value;

  String get password => passwordFieldController.text.trim();
  String get passwordAgain => passWordAgainController.text.trim();

  String get email => emailController.text.trim();

  @override
  void onInit() {
    phoneNode.addListener(() {
      emailController.text = emailController.text.trim();
    });
    super.onInit();
  }

  String? accountValidation(String? value) {
    if (value != null && StringExtensions(value).isEmail()) {
      return null;
    } else {
      return S.current.invalidEmailAddress;
    }
  }

  String? passWordAgain(String? value) {
    if (value != null && value == password) {
      return null;
    } else {
      return S.current.noMatchPass;
    }
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
    if (password.isEmpty || email.isEmpty || passwordAgain.isEmpty) {
      return false;
    } else {
      return signUpFormGlobalKey.currentState?.validate() ?? false;
    }
  }

  void checkFormValidation() {
    if (isFormValided) {
      enableSignUpBtn = true;
    } else {
      enableSignUpBtn = false;
    }
  }

  Future<void> signUpClick() async {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        processingDialog.hide();
        Get.back(result: true);
      });
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      processingDialog.hide();
      SnackBars.error(message: S.current.signuperror).show();
    } catch (e) {
      processingDialog.hide();
      SnackBars.error(message: S.current.signuperror).show();
    }
  }
}
