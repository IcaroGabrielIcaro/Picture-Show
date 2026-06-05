import 'package:flutter/material.dart';
import 'package:picture_show/core/routers/app_router.dart';
import 'package:picture_show/data/datasources/mock/post_mock_datasource.dart';
import 'package:picture_show/data/datasources/mock/profile_mock_datasource.dart';
import 'package:picture_show/data/repositories/post_repository.dart';
import 'package:picture_show/data/repositories/post_repository_impl.dart';
import 'package:picture_show/data/repositories/profile_repository.dart';
import 'package:picture_show/data/repositories/profile_repository_impl.dart';
import 'package:picture_show/features/perfil/providers/profile_provider.dart';
import 'package:picture_show/features/post/providers/post_provider.dart';
import 'package:provider/provider.dart';

void main() {
  final profileDatasource = ProfileMockDatasource();
  final postDatasource = PostMockDatasource(profileDatasource);
  final profileRepository = ProfileRepositoryImpl(profileDatasource);
  final postRepository = PostRepositoryImpl(postDatasource);

  runApp(MyApp(
    profileRepository: profileRepository,
    postRepository: postRepository
  ));
}

class MyApp extends StatelessWidget {
  final ProfileRepository profileRepository;
  final PostRepository postRepository;

  const MyApp({
    super.key,
    required this.profileRepository,
    required this.postRepository
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final provider = ProfileProvider(profileRepository);
            provider.loadProfiles();
            return provider;
          }
        ),

        ChangeNotifierProvider(
          create: (_) {
            final provider = PostProvider(postRepository);
            provider.loadPosts();
            return provider;
          }
        ),
      ],

      child: MaterialApp.router(
        routerConfig: appRouter,
      ),
    );
  }
}