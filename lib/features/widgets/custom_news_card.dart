import 'package:edir/core/constants/colors.dart';
import 'package:edir/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeNewsCard extends StatelessWidget {
  const CustomeNewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        color: AppColors.secondaryWhite,
        height: 200,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ማስታወቂያ',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'ነግ ማለት በቀን 02/01/2016 የወርሃዊ ስብሰባችን ስለሆነ ሁላችሁም እንድትገኙ።',
            ),
            Text(
              'ማንም እንዳይቀር!',
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sep 12,2023',
                ),
                CustomTextButton(
                  buttonName: 'Read more',
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
