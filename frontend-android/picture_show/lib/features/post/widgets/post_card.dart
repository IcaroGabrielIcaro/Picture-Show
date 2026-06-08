import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picture_show/features/perfil/providers/profile_provider.dart';
import 'package:picture_show/features/post/entities/post.dart';
import 'package:picture_show/shared/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

class FeedPostCard extends StatefulWidget {

  final Post post;
  
  const FeedPostCard({
    super.key,
    required this.post,
  });

  @override
  State<FeedPostCard> createState() => _FeedPostCardState();
}

class _FeedPostCardState extends State<FeedPostCard> {

  late bool isLiked;
  late int likes;

  @override
  void initState() {
    super.initState();

    isLiked = widget.post.isLiked;
    likes = widget.post.likes;
  }

  void toggleLike() {

    setState(() {

      if (isLiked) {
        likes--;
      } else {
        likes++;
      }

      isLiked = !isLiked;

    });

  }

  @override
  Widget build(BuildContext context) {

    final profileProvider = context.watch<ProfileProvider>();
    final author = profileProvider.getProfileById(widget.post.authorId);

    if (author == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              InkWell(
                onTap: () {
                  context.pushNamed('perfil', extra: author);
                },
                borderRadius: BorderRadius.circular(12),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(author.photoUrl),
                    ),
                    const SizedBox(width: 10),
                    Text(author.name, style: AppTextStyles.subtitle)
                  ],
                ),
              ),
              Text(widget.post.publishedAt, style: AppTextStyles.body.copyWith(fontSize: 14))
            ],
          ),

          const SizedBox(height: 10),

          GestureDetector(
            onDoubleTap: toggleLike,

            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                widget.post.imagePath,
                height: 400,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10),

              Row(
                children: [

                  GestureDetector(
                    onTap: toggleLike,
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? const Color(0xFF3C3535) : const Color(0xFF3C3535),
                    ),
                  ),

                  const SizedBox(width: 6),

                  Transform.translate(
                    offset: const Offset(0, 1),
                    child: Text('$likes', style: AppTextStyles.body.copyWith(fontSize: 18))
                  )
                ],
              ),

              const SizedBox(height: 8),

              RichText(
                text: TextSpan(
                  style: AppTextStyles.body,
                  children: [
                    TextSpan(text: '${author.name} ', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                    TextSpan(text: widget.post.description),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}