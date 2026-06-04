import 'package:flutter/material.dart';
import 'package:picture_show/features/perfil/entities/profile.dart';
import 'package:picture_show/features/perfil/entities/profile_posts.dart';
import 'package:go_router/go_router.dart';
import 'package:picture_show/shared/entities/post.dart';

class PerfilPostsGrid extends StatelessWidget {

  final Profile profile;
  final List<Post> posts;

  const PerfilPostsGrid({
    super.key,
    required this.profile,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {

    return GridView.builder(

      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      itemCount: posts.length,

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 0.85,
      ),

      itemBuilder: (context, index) {

        final post = posts[index];

        return GestureDetector(

          onTap: () {

            context.pushNamed(
              'perfil-posts',
              extra: PerfilPostsArgs(
                profile: profile,
                initialIndex: index,
              ),
            );

          },

          child: Opacity(

            opacity: 0.8,

            child: Image.asset(
              post.imagePath,
              fit: BoxFit.cover,
            ),

          ),

        );

      },

    );

  }
}