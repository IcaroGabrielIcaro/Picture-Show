import 'package:flutter/material.dart';
import 'package:picture_show/features/perfil/entities/profile.dart';
import 'package:picture_show/shared/theme/app_text_styles.dart';

class PerfilStats extends StatelessWidget {

  final bool isLargeScreen;
  final Profile profile;
  final int totalPosts;

  const PerfilStats({
    super.key,
    required this.isLargeScreen,
    required this.profile,
    required this.totalPosts,
  });

  Widget buildItem(String label, String value) {
    return Row(
      children: [
        Text(value, style: AppTextStyles.body.copyWith(fontSize: isLargeScreen ? 24 : 16)),
        SizedBox(width: isLargeScreen ? 12 : 6),
        Text(label, style: AppTextStyles.body.copyWith(fontSize: isLargeScreen ? 20 : 18))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(

      mainAxisSize: MainAxisSize.min,

      children: [
        buildItem('Fotos', totalPosts.toString()),
        SizedBox(width: isLargeScreen ? 24 : 12),
        buildItem('Seguidores', profile.followers.toString()),
        SizedBox(width: isLargeScreen ? 24 : 12),
        buildItem('Seguindo', profile.following.toString()),
      ],
    );
  }
}