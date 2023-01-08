import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socion/components/show_toast.dart';
import 'package:socion/firebase_auth/auth_exception_handler.dart';
import 'package:socion/provider/auth_service.dart';
import 'package:socion/screens/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import '/components/blur_container.dart';
import '/components/buttons.dart';
import '/components/social_icon_buttons_row.dart';
import '/components/textfields.dart';
import '/constants/images.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = '/signup';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _blurAnimationController;
  TextEditingController usename = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  void initState() {
    _blurAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 0,
      upperBound: 5,
    );
    super.initState();
    _blurAnimationController.forward();
    _blurAnimationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    email.dispose();
    usename.dispose();
    password.dispose();
    _blurAnimationController.dispose();
    super.dispose();
  }

  AuthResultStatus? status;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AuthService>(builder: (context, value, child) {
      return Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.all(15),
          child: Form(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              double.infinity.widthBox,
              SizedBox(
                height: size.height * 0.05,
              ),
              // const Spacer(),
              _buildTitleText(context),
              SizedBox(
                height: size.height * 0.05,
              ),

              // const Spacer(),
              PrimaryTextField(
                hintText: 'Name',
                prefixIcon: Icons.person,
                controller: usename,
              ),
              // 24.heightBox,
              PrimaryTextField(
                hintText: 'Password',
                prefixIcon: CupertinoIcons.padlock,
                controller: password,
              ),
              // 24.heightBox,
              PrimaryTextField(
                hintText: 'Email address',
                prefixIcon: CupertinoIcons.mail_solid,
                controller: email,
              ),
              // 24.heightBox,
              PrimaryTextField(
                hintText: 'Phone',
                prefixIcon: CupertinoIcons.phone_fill,
                controller: phone,
              ),
              // 24.heightBox,
              PrimaryTextField(
                hintText: 'Address',
                prefixIcon: CupertinoIcons.location,
                controller: address,
              ),
              // const Spacer(),
              buildSignInGradientButtonRow(context, 'Create', () async {
                _submitClick();
              }),
              const Spacer(),
            ],
          )),
        ),
      );
    });
  }

  Future<void> _submitClick() async {
    var provider = Provider.of<AuthService>(context, listen: false);
    provider.isLoading = true;
    status = await provider.requestRegister(email.text, password.text);
    if (status == AuthResultStatus.successful) {
      showToast("Login Successful", Colors.greenAccent);
      Navigator.pushReplacementNamed(context, HomeScreen.id);
      provider.isLoading = true;
    } else {
      final errorMessage =
          AuthExceptionHandler.generateExceptionMessage(status);
      if (errorMessage.toString().isEmpty) {
      } else {
        showToast(errorMessage, Colors.redAccent);
      }
    }
  }

  Column _buildTitleText(BuildContext context) {
    return Column(
      children: [
        Text(
          'Create account',
          softWrap: true,
          style: Theme.of(context).textTheme.headline4!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
