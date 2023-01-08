import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socion/components/show_toast.dart';
import 'package:socion/firebase_auth/auth_exception_handler.dart';
import 'package:socion/firebase_auth/firebase_auth.dart';
import 'package:socion/provider/auth_service.dart';
import 'package:socion/screens/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '/components/blur_container.dart';
import '/components/buttons.dart';
import '/components/textfields.dart';
import '/constants/images.dart';
import '/screens/signup.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _blurAnimationController;
  TextEditingController usename = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    _blurAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
      lowerBound: 0,
      upperBound: 6,
    );
    super.initState();
    _blurAnimationController.forward();
    _blurAnimationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _blurAnimationController.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              Images.loginBg,
            ),
            fit: BoxFit.cover,
          )),
        ),
        BlurContainer(value: _blurAnimationController.value),
        SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                double.infinity.widthBox,
                const Spacer(),
                _buildTitleText(context),
                const Spacer(),
                PrimaryTextField(
                  hintText: 'Name',
                  validateText: "This field must not be empty!",
                  prefixIcon: Icons.person,
                  controller: usename,
                ),
                24.heightBox,
                PrimaryTextField(
                  hintText: 'Password',
                  validateText: "This field must not be empty!",
                  prefixIcon: CupertinoIcons.padlock,
                  controller: password,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: const ButtonStyle(),
                      child: const Text(
                        'Forgot your password?',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    24.widthBox,
                  ],
                ),
                const Spacer(),
                buildSignInGradientButtonRow(context, 'Sign In', () {
                  if (_formKey.currentState!.validate()) {
                    final status =
                        AuthService().requestLogin(usename.text, password.text);
                    if (status == AuthResultStatus.successful) {
                      showToast("Login Succesful", Colors.greenAccent);
                      Navigator.pushReplacementNamed(context, HomeScreen.id);
                    }
                    final errorMessage =
                        AuthExceptionHandler.generateExceptionMessage(status);
                    showToast(errorMessage, Colors.red);
                  }
                }),
                const Spacer(),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Don\'t have an account?  ',
                        style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).colorScheme.onBackground)),
                    TextSpan(
                        text: 'Create',
                        style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamed(SignUpScreen.id);
                          }),
                  ]),
                ),
              ],
            ).p(24),
          ),
        ),
      ]),
    );
  }



  Column _buildTitleText(BuildContext context) {
    return Column(
      children: [
        Text(
          'Hello',
          softWrap: true,
          style: TextStyle(
              fontSize: 85,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onBackground),
        ),
        Text(
          'Sign in to your account',
          softWrap: true,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}
