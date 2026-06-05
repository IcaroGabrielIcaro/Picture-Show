import 'package:picture_show/features/perfil/entities/profile.dart';

class Post {

  final Profile author;

  final String imagePath;
  final String description;
  final String publishedAt;

  final int likes;
  final bool isLiked;

  const Post({
    required this.author,
    required this.imagePath,
    required this.description,
    required this.publishedAt,
    required this.likes,
    required this.isLiked,
  });

}