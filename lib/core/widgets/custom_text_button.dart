import 'package:edir/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  const CustomTextButton({
    Key? key,
    required this.buttonName,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        buttonName,
        style: GoogleFonts.poppins(
          color: AppColors.primaryColor,
          fontSize: 18,
        ),
      ),
    );
  }
}
