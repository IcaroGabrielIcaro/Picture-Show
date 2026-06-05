import 'package:picture_show/features/perfil/entities/profile.dart';

class ProfileModel extends Profile {

  const ProfileModel({
    required super.id,
    required super.name,
    required super.photoUrl,
    required super.bio,
    required super.followers,
    required super.following,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as int,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String,
      bio: json['bio'] as String,
      followers: json['followers'] as int,
      following: json['following'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'bio': bio,
      'followers': followers,
      'following': following,
    };
  }

  factory ProfileModel.fromEntity(Profile profile) {
    return ProfileModel(
      id: profile.id,
      name: profile.name,
      photoUrl: profile.photoUrl,
      bio: profile.bio,
      followers: profile.followers,
      following: profile.following,
    );
  }
}