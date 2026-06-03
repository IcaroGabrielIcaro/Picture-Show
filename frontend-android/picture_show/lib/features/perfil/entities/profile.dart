class Profile {

  final String name;
  final String photoUrl;
  final String bio;

  final int posts;
  final int followers;
  final int following;

  final List<String> images;

  const Profile({
    required this.name,
    required this.photoUrl,
    required this.bio,
    required this.posts,
    required this.followers,
    required this.following,
    required this.images,
  });
  
}