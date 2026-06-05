import 'package:flutter/material.dart';
import 'package:picture_show/features/perfil/entities/profile.dart';
import 'package:picture_show/features/perfil/mock/profiles_mock.dart';

class ProfileProvider extends ChangeNotifier {
  final List<Profile> _profiles = profilesMock;

  List<Profile> get profiles => _profiles;

  Profile getProfileById(int id) {
    return _profiles.firstWhere(
      (profile) => profile.id == id,
    );
  }

  void updateProfile({
    required int id,
    required String name,
    required String bio,
  }) {

    final index = _profiles.indexWhere(
      (profile) => profile.id == id,
    );

    if (index == -1) return;

    _profiles[index] = _profiles[index].copyWith(
      name: name,
      bio: bio,
    );

    notifyListeners();
  }
}