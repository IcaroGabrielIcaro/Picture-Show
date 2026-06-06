import 'package:flutter/material.dart';
import 'package:picture_show/data/repositories/post/post_repository.dart';
import 'package:picture_show/features/post/entities/post.dart';

class PostProvider extends ChangeNotifier {
  final PostRepository repository;

  PostProvider(this.repository);

  List<Post> _posts = [];

  List<Post> get posts => _posts;

  Future<void> loadPosts() async {
    _posts = await repository.getPosts();
    notifyListeners();
  }

  List<Post> getPostsByProfileId(int profileId) {
    return _posts.where((post) =>post.author.id == profileId,).toList();
  }
}