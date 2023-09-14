import 'package:edir/core/widgets/custom_text_button.dart';
import 'package:edir/features/screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:edir/core/widgets/custom_button.dart';
import 'package:edir/core/widgets/custom_snack_bar.dart';
import 'package:edir/core/widgets/custom_text_form_field.dart';
import 'package:edir/features/screen/home.dart';
import 'package:edir/features/services/sign_up_service.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _signUpFomKey = GlobalKey<FormState>();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _mnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final SignUpService _signUpService = SignUpService();

  @override
  void dispose() {
    _fnameController.dispose();
    _mnameController.dispose();
    _lnameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void signUp() async {
    await _signUpService.signUpUser(
      context: context,
      firstName: _fnameController.text,
      middleName: _mnameController.text,
      lastName: _lnameController.text,
      username: _usernameController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signUpFomKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _fnameController,
            hintText: 'First Name',
          ),
          const SizedBox(height: 26),
          CustomTextFormField(
            controller: _mnameController,
            hintText: 'Middle Name',
          ),
          const SizedBox(height: 26),
          CustomTextFormField(
            controller: _lnameController,
            hintText: 'Last Name',
          ),
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
          // const SizedBox(height: 26),
          // CustomTextFormField(
          //   controller: _confirmPasswordController,
          //   hintText: 'Confirm Password',
          //   obscureText: true,
          // ),
          const SizedBox(height: 26),
          Text(
            'By creating an account, you agree to the Terms and Use and Privicy Policy',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 26),
          CustomButton(
            buttonName: 'Register',
            onPressed: () {
              if (_signUpFomKey.currentState!.validate()) {
                signUp();
                // if (_passwordController.text ==
                //     _confirmPasswordController.text) {
                //   signUp();
                // } else {
                //   CustomSnackBar.showSnackBar(
                //     context: context,
                //     text: 'Password and Confirm Password does not match',
                //   );
                // }
              }
            },
          ),
          const SizedBox(height: 26),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Already have an account?'),
              CustomTextButton(
                  buttonName: 'Login',
                  onPressed: () {
                    Navigator.pushNamed(context, SignInScreen.routeName);
                  })
            ],
          )
        ],
      ),
    );
  }
}
