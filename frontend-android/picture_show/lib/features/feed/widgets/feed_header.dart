import 'package:flutter/material.dart';
import 'package:picture_show/shared/theme/app_text_styles.dart';

class FeedHeader extends StatelessWidget {
  const FeedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Picture Show', style: AppTextStyles.logo.copyWith(fontSize: 32))
      ],
    );
  }
}
