class Post {

  final int authorId;

  final String imagePath;
  final String description;
  final String publishedAt;

  final int likes;
  final bool isLiked;

  const Post({
    required this.authorId,
    required this.imagePath,
    required this.description,
    required this.publishedAt,
    required this.likes,
    required this.isLiked,
  });

}