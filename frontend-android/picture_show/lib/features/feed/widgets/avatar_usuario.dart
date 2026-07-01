import 'package:flutter/material.dart';
import 'package:picture_show/theme/app_colors.dart';

class AvatarUsuario extends StatelessWidget {
  final String? imagem;
  final double radius;

  const AvatarUsuario({super.key, this.imagem, this.radius = 22});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.border,
      backgroundImage: imagem != null && imagem!.isNotEmpty
          ? NetworkImage(imagem!)
          : null,
      child: (imagem == null || imagem!.isEmpty)
          ? Icon(Icons.person, size: radius, color: AppColors.textSecondary)
          : null,
    );
  }
}
