import 'package:flutter/material.dart';

import '../globals/styles/text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.label, this.onPressed});

  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),

        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: montserratBody.copyWith(
            fontSize: 18,
            color: Colors.black,
          ),
        ),

      ),
    );
  }
}
