import 'package:picture_show/data/datasources/mock/profile_mock_datasource.dart';
import 'package:picture_show/data/repositories/profile/profile_repository.dart';
import 'package:picture_show/features/perfil/entities/profile.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileMockDatasource datasource;

  ProfileRepositoryImpl(this.datasource);

  @override
  Future<List<Profile>> getProfiles() {
    return datasource.getProfiles();
  }

  @override
  Future<Profile?> getProfileById(int id) async {
    final profiles = await datasource.getProfiles();

    try {
      return profiles.firstWhere((profile) => profile.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> updateProfile(Profile profile) async {
    await datasource.updateProfile(profile);
  }
}