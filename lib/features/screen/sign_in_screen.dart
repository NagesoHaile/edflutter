import 'package:edir/features/widgets/sign_in_body.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  static const String routeName = '/sign-in';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: const SingleChildScrollView(
        child: SignInBody(),
      )),
    );
  }
}
