import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:edir/core/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.buttonName,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [AppColors.primaryColor, AppColors.secondaryColor],
          ),
        ),
        child: Center(
          child: Text(
            buttonName,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
