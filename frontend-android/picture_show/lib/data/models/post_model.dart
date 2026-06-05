import 'package:picture_show/data/models/profile_model.dart';
import 'package:picture_show/features/post/entities/post.dart';

class PostModel extends Post {

  const PostModel({
    required super.author,
    required super.imagePath,
    required super.description,
    required super.publishedAt,
    required super.likes,
    required super.isLiked,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      author: ProfileModel.fromJson(json['author'] as Map<String, dynamic>),
      imagePath: json['imagePath'] as String,
      description: json['description'] as String,
      publishedAt: json['publishedAt'] as String,
      likes: json['likes'] as int,
      isLiked: json['isLiked'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': ProfileModel.fromEntity(author).toJson(),
      'imagePath': imagePath,
      'description': description,
      'publishedAt': publishedAt,
      'likes': likes,
      'isLiked': isLiked,
    };
  }

  factory PostModel.fromEntity(Post post) {
    return PostModel(
      author: post.author,
      imagePath: post.imagePath,
      description: post.description,
      publishedAt: post.publishedAt,
      likes: post.likes,
      isLiked: post.isLiked,
    );
  }
}