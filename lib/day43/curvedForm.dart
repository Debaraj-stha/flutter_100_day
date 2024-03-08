import 'package:flutter/material.dart';
import 'package:frontend/model-view/login-view.dart';
import 'package:frontend/resources/appColors.dart';
import 'package:frontend/resources/components/bigText.dart';
import 'package:frontend/resources/components/buildTextButton.dart';
import 'package:frontend/resources/components/buildTextField.dart';
import 'package:frontend/resources/components/mediumText.dart';
import 'package:frontend/resources/clipper.dart';
import 'package:frontend/utils/utils.dart';

import '../utils/routes/routeName.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginModelView _loginModelView = LoginModelView();
  @override
  void initState() {
    // TODO: implement initState
    _loginModelView.initFields();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loginModelView.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = Utils.getWidth(context);
    double height = Utils.getHeight(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: MyPathClipper(),
                  child: Container(
                    alignment: Alignment.center,
                    height: Utils.getHeight(context) * 0.4,
                    width: 500,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(color: AppColors.third),
                    child: BigText(
                      text: "LOGIN",
                      color: AppColors.textColorPrimary,
                    ),
                  ),
                ),
                ClipPath(
                  clipper: MyPathClipper(),
                  child: Container(
                    alignment: Alignment.center,
                    height: Utils.getHeight(context) * 0.36,
                    width: 500,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(color: AppColors.primary),
                    child: BigText(
                      text: "LOGIN",
                      color: AppColors.textColorPrimary,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(),
              child: Form(
                key: _loginModelView.formKey,
                child: Column(
                  children: [
                    BuildTextField(
                        label: "Email",
                        type: 1,
                        hint: "Email...",
                        controller: _loginModelView.emailController,
                        focusnode: _loginModelView.emailNode,
                        next: _loginModelView.passwordsNode,
                        onSubmit: (value) {
                          print(value);
                        },
                        prefix: const Icon(Icons.email_outlined),
                        onTapOutSide: () {}),
                    BuildTextField(
                        type: 2,
                        label: "Password",
                        hint: "Password...",
                        controller: _loginModelView.passwordController,
                        focusnode: _loginModelView.passwordsNode,
                        isObsecure: true,
                        onSubmit: (value) {
                          print(value);
                        },
                        prefix: const Icon(Icons.lock_outline),
                        onTapOutSide: () {}),
                    Row(
                      children: [
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.ForgotPassword);
                          },
                          child: MediumText(
                            text: "Forgot password?",
                            color: AppColors.third,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    BuildTextButton(
                      onPressed: () {
                        _loginModelView.handleSubmit(context);
                      },
                      color: AppColors.primary,
                      child: MediumText(
                          text: "Login", color: AppColors.textColorPrimary),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 1,
                          color: AppColors.third,
                          width: width * 0.4,
                        ),
                        const BigText(
                          text: "OR",
                        ),
                        Container(
                          height: 1,
                          color: AppColors.third,
                          width: width * 0.4,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const MediumText(
                      text: "Don't have an account?",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BuildTextButton(
                        color: AppColors.third,
                        child: MediumText(
                          text: "Sign Up Now",
                          color: AppColors.textColorPrimary,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesName.Singup);
                        }),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.third)),
                      label: const Text("Login With Google"),
                      onPressed: () {},
                      icon: const Icon(Icons.facebook_outlined),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
class MyPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    Path path = Path();
    path.moveTo(0, height - 100);
    path.cubicTo(
        60, height * 0.5, width * 0.5, height + 40, width, height - 80);
    path.lineTo(width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
