import 'package:flutter/material.dart';
import 'package:picture_show/features/perfil/entities/profile.dart';
import 'package:picture_show/features/post/providers/post_provider.dart';
import 'package:picture_show/shared/widgets/headers/page_header.dart';
import 'package:picture_show/features/post/widgets/post_card.dart';
import 'package:provider/provider.dart';

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
    
    final postProvider = context.watch<PostProvider>();
    final profilePosts = postProvider.getPostsByProfileId(profile.id);

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

                ...profilePosts.map(
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