import 'package:flutter/material.dart';
import 'package:picture_show/features/feed/widgets/feed_header.dart';
import 'package:picture_show/features/post/providers/post_provider.dart';
import 'package:picture_show/features/post/widgets/post_card.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final posts = context.watch<PostProvider>().posts;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFEEF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FeedHeader(),

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
              ]
            ),
          ),
        ),
      ),
    );

  }
}