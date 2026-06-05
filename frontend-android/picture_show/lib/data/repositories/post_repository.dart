import 'package:picture_show/features/post/entities/post.dart';

abstract class PostRepository {

  Future<List<Post>> getPosts();

  Future<List<Post>> getPostsByProfileId(
    int profileId,
  );
}