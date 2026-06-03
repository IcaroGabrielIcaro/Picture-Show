import 'package:flutter/material.dart';
import 'package:picture_show/features/perfil/entities/profile.dart';

class PerfilPostsGrid extends StatelessWidget {

  final Profile profile;

  const PerfilPostsGrid({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {

    return GridView.builder(

      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: profile.images.length,

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 0.85,
      ),

      itemBuilder: (context, index) {

        return Opacity(

          opacity: 0.8,

          child: Image.network(
            profile.images[index],
            fit: BoxFit.cover,
          ),

        );

      },
    );
  }
}