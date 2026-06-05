class Profile {

  final int id;
  final String name;
  final String photoUrl;
  final String bio;

  final int followers;
  final int following;

  const Profile({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.bio,
    required this.followers,
    required this.following,
  });
  
  Profile copyWith({
    int? id,
    String? name,
    String? photoUrl,
    String? bio,
    int? followers,
    int? following,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }
}