import 'package:flutter/material.dart';

enum ButtonType {
  primary,
  secondary,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final double height;
  final double fontSize;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.height = 42,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPrimary = type == ButtonType.primary;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? const Color(0xFF3C3535) : const Color(0xFFFFFEEF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: isPrimary ? BorderSide.none : const BorderSide(
              color: Color(0xFFD0D0D0),
              width: 1
            )
          ),
        ),

        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'JosefinSlab',
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: isPrimary ? const Color(0xFFFFFEEF) : const Color(0xFF3C3535),
          ),
        ),
      ),
    );
  }
}