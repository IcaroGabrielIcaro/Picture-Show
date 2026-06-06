import 'package:flutter/material.dart';
import 'package:picture_show/core/routers/app_router.dart';
import 'package:picture_show/core/services/secure_storage_service.dart';
import 'package:picture_show/data/datasources/mock/auth_mock_datasource.dart';
import 'package:picture_show/data/datasources/mock/post_mock_datasource.dart';
import 'package:picture_show/data/datasources/mock/profile_mock_datasource.dart';
import 'package:picture_show/data/repositories/auth/auth_repository_impl.dart';
import 'package:picture_show/data/repositories/post/post_repository.dart';
import 'package:picture_show/data/repositories/post/post_repository_impl.dart';
import 'package:picture_show/data/repositories/profile/profile_repository.dart';
import 'package:picture_show/data/repositories/profile/profile_repository_impl.dart';
import 'package:picture_show/features/auth/providers/auth_provider.dart';
import 'package:picture_show/features/perfil/providers/profile_provider.dart';
import 'package:picture_show/features/post/providers/post_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  final profileDatasource = ProfileMockDatasource();
  final postDatasource = PostMockDatasource(profileDatasource);
  final authDatasource = AuthMockDatasource();

  final secureStorageService = SecureStorageService();

  final profileRepository = ProfileRepositoryImpl(profileDatasource);
  final postRepository = PostRepositoryImpl(postDatasource);
  final authRepository = AuthRepositoryImpl(authDatasource);

  final authProvider = AuthProvider(authRepository, secureStorageService);
  await authProvider.initialize();

  runApp(MyApp(
    profileRepository: profileRepository,
    postRepository: postRepository,
    authProvider: authProvider,
  ));
}

class MyApp extends StatelessWidget {
  final ProfileRepository profileRepository;
  final PostRepository postRepository;
  final AuthProvider authProvider;

  const MyApp({
    super.key,
    required this.profileRepository,
    required this.postRepository,
    required this.authProvider
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

        ChangeNotifierProvider.value(value: authProvider)
      ],

      child: MaterialApp.router(
        routerConfig: createRouter(authProvider),
      ),
    );
  }
}