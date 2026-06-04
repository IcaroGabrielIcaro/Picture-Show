import 'package:picture_show/features/perfil/entities/profile.dart';

class PerfilPostsArgs {

  final Profile profile;
  final int initialIndex;

  const PerfilPostsArgs({
    required this.profile,
    required this.initialIndex,
  });

}