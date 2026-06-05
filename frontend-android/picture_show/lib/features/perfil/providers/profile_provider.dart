import 'package:flutter/material.dart';
import 'package:picture_show/data/repositories/profile_repository.dart';
import 'package:picture_show/features/perfil/entities/profile.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository repository;

  ProfileProvider(this.repository);

  List<Profile> _profiles = [];

  Future<void> loadProfiles() async {
    _profiles = await repository.getProfiles();

    notifyListeners();
  }

  Profile? getProfileById(int id) {
    try {
      return _profiles.firstWhere((profile) => profile.id == id);
    } catch (_) {
      // caso perfil não exista
      return null;
    }
  }

  void updateProfile({
    required int id,
    required String name,
    required String bio
  }) async {

    final index = _profiles.indexWhere((profile) => profile.id == id);
    if (index == -1) return;

    final updatedProfile = _profiles[index].copyWith(name: name, bio: bio);
    await repository.updateProfile(updatedProfile);

    _profiles[index] = updatedProfile;
    notifyListeners();
  }
}