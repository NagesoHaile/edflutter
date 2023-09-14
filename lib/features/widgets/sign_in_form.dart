import 'package:edir/core/widgets/custom_button.dart';
import 'package:edir/core/widgets/custom_text_button.dart';
import 'package:edir/core/widgets/custom_text_form_field.dart';
import 'package:edir/features/screen/home.dart';
import 'package:edir/features/services/sign_in_service.dart';
import 'package:flutter/material.dart';
import 'package:edir/core/controllers/controller.dart';
import 'package:get/get.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SignInService _signInService = SignInService();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signIn() async {
    await _signInService.signInUser(
      context: context,
      username: _usernameController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signInFormKey,
      child: Column(children: [
        const SizedBox(height: 26),
        CustomTextFormField(
          controller: _usernameController,
          hintText: 'username',
        ),
        const SizedBox(height: 26),
        CustomTextFormField(
          controller: _passwordController,
          hintText: 'Password',
          obscureText: true,
        ),
        const SizedBox(height: 26),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomTextButton(buttonName: 'forgot password?', onPressed: () {})
          ],
        ),
        CustomButton(
            buttonName: 'Login',
            onPressed: () async {
              if (_signInFormKey.currentState!.validate()) {
                signIn();
              }
              // final username = _signInService.getUserData();
              if (userController.user.username.isNotEmpty) {
                // Navigator.pushNamedAndRemoveUntil(
                //     context, Home.routeName, (route) => false);
                final username = await _signInService.getUserData();
                print(userController.user.username);
                print(userController.user.username);
                Get.offNamed(Home.routeName, arguments: username);
              }
            }),
      ]),
    );
  }
}
