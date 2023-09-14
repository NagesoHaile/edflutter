import 'package:edir/core/constants/colors.dart';
import 'package:edir/features/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Register to get start',
            style: GoogleFonts.sansita(
              color: AppColors.primaryColor,
              fontSize: 36,
            ),
          ),
          const SizedBox(height: 30),
          const SignUpForm(),
        ],
      ),
    );
  }
}
