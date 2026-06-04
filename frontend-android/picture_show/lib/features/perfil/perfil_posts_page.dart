import 'package:flutter/material.dart';
import 'package:picture_show/features/perfil/entities/profile.dart';
import 'package:picture_show/shared/mock/posts_mock.dart';
import 'package:picture_show/shared/widgets/headers/page_header.dart';
import 'package:picture_show/shared/widgets/posts/post_card.dart';

class PerfilPostsPage extends StatelessWidget{

  final Profile profile;
  final int initialIndex;

  const PerfilPostsPage({
    super.key,
    required this.profile,
    required this.initialIndex
  });

  @override
  Widget build(BuildContext context) {
    
    final posts = postsMock
      .where((post) => post.author == profile)
      .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFFFEEF),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                PageHeader(nome: "Posts"),

                const SizedBox(height: 12),

                const Divider(
                  color: Color(0xFF3C3535),
                  thickness: 1,
                ),

                const SizedBox(height: 12),

                ...posts.map(
                  (post) => FeedPostCard(
                    post: post,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}