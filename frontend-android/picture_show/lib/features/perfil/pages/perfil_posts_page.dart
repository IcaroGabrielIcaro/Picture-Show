import 'package:flutter/material.dart';
import 'package:picture_show/features/perfil/entities/profile.dart';
import 'package:picture_show/features/post/providers/post_provider.dart';
import 'package:picture_show/shared/widgets/headers/page_header.dart';
import 'package:picture_show/features/post/widgets/post_card.dart';
import 'package:provider/provider.dart';

class PerfilPostsPage extends StatefulWidget {

  final Profile profile;
  final int initialIndex;

  const PerfilPostsPage({
    super.key,
    required this.profile,
    required this.initialIndex,
  });

  @override
  State<PerfilPostsPage> createState() => _PerfilPostsPageState();
}

class _PerfilPostsPageState extends State<PerfilPostsPage> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      const estimatedPostHeight = 545.0;
      _scrollController.jumpTo(widget.initialIndex * estimatedPostHeight);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final postProvider = context.watch<PostProvider>();
    final profilePosts = postProvider.getPostsByProfileId(widget.profile.id);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFEEF),

      body: SafeArea(
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          itemCount: profilePosts.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const Column(
                children: [
                  PageHeader(nome: 'Posts'),
                  SizedBox(height: 12),
                  Divider(color: Color(0xFF3C3535), thickness: 1),
                  SizedBox(height: 12),
                ],
              );
            }

            final post = profilePosts[index - 1];

            return FeedPostCard(post: post);
          }
        ),
      ),
    );
  }
}