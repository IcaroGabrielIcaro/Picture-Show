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
  
}