import 'package:flutter/material.dart';
import 'package:picture_show/core/routers/app_router.dart';
import 'package:picture_show/core/services/secure_storage_service.dart';
import 'package:picture_show/data/datasources/mock/auth_mock_datasource.dart';
import 'package:picture_show/data/datasources/mock/post_mock_datasource.dart';
import 'package:picture_show/data/datasources/mock/profile_mock_datasource.dart';
import 'package:picture_show/data/repositories/auth/auth_repository_impl.dart';
import 'package:picture_show/data/repositories/post/post_repository_impl.dart';
import 'package:picture_show/data/repositories/profile/profile_repository_impl.dart';
import 'package:picture_show/features/auth/providers/auth_provider.dart';
import 'package:picture_show/features/perfil/providers/profile_provider.dart';
import 'package:picture_show/features/post/providers/post_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final profileDatasource = ProfileMockDatasource();
  final postDatasource = PostMockDatasource(profileDatasource);
  final authDatasource = AuthMockDatasource();

  final secureStorageService = SecureStorageService();

  final profileRepository = ProfileRepositoryImpl(profileDatasource);
  final postRepository = PostRepositoryImpl(postDatasource);
  final authRepository = AuthRepositoryImpl(authDatasource);

  final profileProvider = ProfileProvider(profileRepository);
  await profileProvider.loadProfiles();
  final postProvider = PostProvider(postRepository);
  await postProvider.loadPosts();
  final authProvider = AuthProvider(authRepository, secureStorageService);
  await authProvider.initialize();

  runApp(MyApp(
    profileProvider: profileProvider,
    postProvider: postProvider,
    authProvider: authProvider,
  ));
}

class MyApp extends StatelessWidget {
  final ProfileProvider profileProvider;
  final PostProvider postProvider;
  final AuthProvider authProvider;

  const MyApp({
    super.key,
    required this.profileProvider,
    required this.postProvider,
    required this.authProvider
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: profileProvider),

        ChangeNotifierProvider.value(value: postProvider),

        ChangeNotifierProvider.value(value: authProvider)
      ],

      child: MaterialApp.router(
        routerConfig: createRouter(authProvider),
      ),
    );
  }
}