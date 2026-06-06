import 'package:flutter/material.dart';
import 'package:picture_show/data/repositories/post/post_repository.dart';
import 'package:picture_show/features/post/entities/post.dart';

class PostProvider extends ChangeNotifier {
  final PostRepository repository;

  PostProvider(this.repository);

  static const int pageSize = 10;

  List<Post> _allPosts = [];
  List<Post> _visiblePosts = [];

  List<Post> get posts => _visiblePosts;

  Future<void> loadPosts() async {
    _allPosts = await repository.getPosts();
    _visiblePosts = _allPosts.take(pageSize).toList();
    notifyListeners();
  }

  Future<void> loadMorePosts() async {

    if (_visiblePosts.length >= _allPosts.length) return;

    final nextCount = (_visiblePosts.length + pageSize).clamp(0, _allPosts.length);
    _visiblePosts = _allPosts.take(nextCount).toList();
    notifyListeners();
  }

  List<Post> getPostsByProfileId(int profileId) {
    return _allPosts.where((post) =>post.author.id == profileId).toList();
  }
}