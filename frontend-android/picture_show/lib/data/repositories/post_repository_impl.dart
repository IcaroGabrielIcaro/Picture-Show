import 'package:picture_show/data/datasources/mock/post_mock_datasource.dart';
import 'package:picture_show/data/repositories/post_repository.dart';
import 'package:picture_show/features/post/entities/post.dart';

class PostRepositoryImpl implements PostRepository {
  final PostMockDatasource datasource;

  PostRepositoryImpl(this.datasource);

  @override
  Future<List<Post>> getPosts() {
    return datasource.getPosts();
  }

  @override
  Future<List<Post>> getPostsByProfileId(int profileId) async {
    final posts = await datasource.getPosts();

    return posts.where((post) => post.author.id == profileId).toList();
  }
}