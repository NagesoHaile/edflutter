import 'package:edir/core/constants/colors.dart';
import 'package:edir/core/widgets/custom_button.dart';
import 'package:edir/core/widgets/custom_text_button.dart';
import 'package:edir/features/screen/sign_up_screen.dart';
import 'package:edir/features/widgets/sign_in_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:edir/core/routes/routing.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello there, \nWelcome back',
            style: GoogleFonts.sansita(
              fontSize: 36,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          const SignInForm(),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Don\'t have an account?',
                style: GoogleFonts.sansita(
                  color: AppColors.dark,
                  fontSize: 16,
                ),
              ),
              CustomTextButton(
                  buttonName: 'Register',
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpScreen.routeName);
                  })
            ],
          )
        ],
      ),
    );
  }
}
