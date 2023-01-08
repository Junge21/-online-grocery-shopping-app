import 'package:flutter/cupertino.dart';
import 'package:socion/firebase_auth/auth_exception_handler.dart';
import 'package:socion/firebase_auth/firebase_auth.dart';
import 'package:socion/model/sign_in_request.dart';
import 'package:socion/model/sign_up_request.dart';

class AuthService extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<AuthResultStatus?> requestRegister(
      String username, String password) async {
    final status = await Account()
        .createAccount(SignUpRequest(email: username, password: password));
    return status;
  }

  Future<AuthResultStatus?> requestLogin(
      String username, String password) async {
    final status = await Account()
        .login(LoginRequest(username: username, password: password));
    return status;
  }
}
