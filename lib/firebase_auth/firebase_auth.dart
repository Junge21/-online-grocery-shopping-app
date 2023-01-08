import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socion/firebase_auth/auth_exception_handler.dart';
import 'package:socion/model/sign_in_request.dart';

import 'package:socion/model/sign_up_request.dart';

import 'package:socion/utils/shared_prefs_helper.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class Account {
  AuthResultStatus? _status;
  void errorMessage(BuildContext context, String errorMessage) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(errorMessage),
          );
        });
  }

  Future<AuthResultStatus?> createAccount(SignUpRequest request) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: request.email!, password: request.password!);
      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
        SharedPrefsHelper().setBoolToPrefs(true);
      } else {
        _status = AuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<AuthResultStatus?> login(LoginRequest request) async {
    try {
      UserCredential userCredential = (await _auth.signInWithEmailAndPassword(
          email: request.username!, password: request.password!));
      if (userCredential.user != null) {
        _status = AuthResultStatus.successful;
        SharedPrefsHelper().setBoolToPrefs(true);
      } else {
        _status = AuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<void> logOut() async {
    try {
      _auth.signOut();
      SharedPrefsHelper.sharedPrefsHelper.removesValues();
    } on FirebaseAuthException catch (e) {
      log(e.code);
    }
  }
}
