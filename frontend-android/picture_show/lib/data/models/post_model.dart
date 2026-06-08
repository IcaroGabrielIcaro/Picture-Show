import 'package:picture_show/features/post/entities/post.dart';

class PostModel extends Post {

  const PostModel({
    required super.authorId,
    required super.imagePath,
    required super.description,
    required super.publishedAt,
    required super.likes,
    required super.isLiked,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      authorId: json['authorId'] as int,
      imagePath: json['imagePath'] as String,
      description: json['description'] as String,
      publishedAt: json['publishedAt'] as String,
      likes: json['likes'] as int,
      isLiked: json['isLiked'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authorId': authorId,
      'imagePath': imagePath,
      'description': description,
      'publishedAt': publishedAt,
      'likes': likes,
      'isLiked': isLiked,
    };
  }

  factory PostModel.fromEntity(Post post) {
    return PostModel(
      authorId: post.authorId,
      imagePath: post.imagePath,
      description: post.description,
      publishedAt: post.publishedAt,
      likes: post.likes,
      isLiked: post.isLiked,
    );
  }
}