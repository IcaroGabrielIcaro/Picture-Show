import 'package:flutter/material.dart';

class FeedHeader extends StatelessWidget {
  const FeedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Picture Show',
          style: TextStyle(
            fontFamily: 'OoohBaby',
            fontSize: 32,
            color: Color(0xFF3C3535),
          ),
        ),
      ],
    );
  }
}
