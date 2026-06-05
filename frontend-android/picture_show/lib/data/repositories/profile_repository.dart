import 'package:picture_show/features/perfil/entities/profile.dart';

abstract class ProfileRepository {

  Future<List<Profile>> getProfiles();

  Future<Profile?> getProfileById(int id);

  Future<void> updateProfile(Profile profile);
}