import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.poppins(
        letterSpacing: 0.8,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
        hintStyle: GoogleFonts.poppins(
          color: Colors.grey,
          letterSpacing: 0.8,
        ),
      ),
      obscureText: obscureText,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
    );
  }
}
