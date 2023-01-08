import 'package:firebase_auth/firebase_auth.dart';

class SignUpRequest {
  final String? userName;
  final String? password;
  final String? email;
  final FirebaseAuthException? authException;
  SignUpRequest({this.userName, this.password,this.authException, this.email});
}
