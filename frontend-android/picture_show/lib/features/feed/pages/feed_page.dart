import 'package:flutter/material.dart';
import 'package:picture_show/features/feed/widgets/feed_header.dart';
import 'package:picture_show/features/post/providers/post_provider.dart';
import 'package:picture_show/features/post/widgets/post_card.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}


class _FeedPageState extends State<FeedPage> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 300) {
      context.read<PostProvider>().loadMorePosts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final posts = context.watch<PostProvider>().posts;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFEEF),
      body: SafeArea(
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          itemCount: posts.length + 3,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const FeedHeader();
            }

            if (index == 1) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(
                  color: Color(0xFF3C3535),
                  thickness: 1,
                ),
              );
            }

            if (index == posts.length + 2) {
              return const SizedBox(height: 24);
            }

            final post = posts[index - 2];

            return FeedPostCard(
              post: post,
            );
          }
        ),
      ),
    );

  }
}