import 'package:flutter/material.dart';
import 'package:picture_show/features/feed/widgets/feed_header.dart';
import 'package:picture_show/features/feed/widgets/feed_post_card.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEEF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                FeedHeader(),

                SizedBox(height: 12),

                Divider(
                  color: Color(0xFF3C3535),
                  thickness: 1,
                ),

                SizedBox(height: 12),

                FeedPostCard(),

                SizedBox(height: 12),

                FeedPostCard(),
              ],
            ),
          ),
        ),
      ),
    );

  }
}