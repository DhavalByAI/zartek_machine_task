import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Core/Const/app_const.dart';
import '../../Routes/app_routes.dart';

class AuthController extends GetxController {
  bool isMobile = false;
  bool isOtp = false;
  bool isChecked = false;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String verificationId = '';

  bool mobileValidation() {
    return phoneNumberController.text.length < 10 ? true : false;
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential authResult = await auth.signInWithCredential(credential);
      user = authResult.user;
      Get.offAllNamed(AppRoutes.homeScreen);
    } catch (e) {
      Get.snackbar('Signin Failed', e.toString());
      log(e.toString());
    }
    update();
  }

  verifyOtp() async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text,
      );
      UserCredential authResult = await auth.signInWithCredential(credential);
      user = authResult.user!;
      Get.offAllNamed(AppRoutes.homeScreen);
      log('User ID: ${user?.uid}');
    } catch (e) {
      Get.snackbar('Verification Failed, Please Try Again', e.toString());
      isMobile = false;
      isOtp = false;
      isChecked = false;
      otpController.clear();
      log('Login Failed: $e');
    }
    update();
  }

  verifyMobile() async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+91${phoneNumberController.text}',
      timeout: const Duration(seconds: 60),
      verificationCompleted: (phoneAuthCredential) async {
        await auth.signInWithCredential(phoneAuthCredential);
        Get.offAllNamed(AppRoutes.homeScreen);
        update();
      },
      verificationFailed: (error) {
        Get.snackbar('Verification Failed', error.message.toString());
        isMobile = false;
        isOtp = false;
        isChecked = false;
        otpController.clear();
        update();
      },
      codeSent: (verificationId, forceResendingToken) {
        verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        verificationId = verificationId;
      },
    );
    isOtp = true;
    update();
  }
}
