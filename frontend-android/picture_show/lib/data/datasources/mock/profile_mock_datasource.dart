import 'package:picture_show/features/perfil/entities/profile.dart';

class ProfileMockDatasource {

  final List<Profile> _profiles = [
    Profile(
      id: 0,
      name: 'Nicolas Cage',
      photoUrl: 'https://m.media-amazon.com/images/M/MV5BMTUzMDM4Nzk2MV5BMl5BanBnXkFtZTcwNTcwNjExOQ@@._V1_.jpg',
      bio: 'Ator muito massa que faz filmes surtados porque sim. Me dê motivos para ele não ter feito.',
      followers: 320,
      following: 45,
    ),

    Profile(
      id: 1,
      name: 'Keanu Reeves',
      photoUrl: 'https://tse4.mm.bing.net/th/id/OIP.2MoNt9-6QUnt14VDKB3S-wHaEK?cb=thfc1falcon&rs=1&pid=ImgDetMain&o=7&rm=3',
      bio: 'Sobrevivi a Matrix e continuo tentando entender a vida.',
      followers: 1500,
      following: 12,
    ),

    Profile(
      id: 2,
      name: 'Pedro Pascal',
      photoUrl: 'https://www.usmagazine.com/wp-content/uploads/2023/01/Pedro-Pascal-Through-the-Years-Mandalorian-early-2000s.jpg?w=1200&quality=86&strip=all',
      bio: 'Protegendo crianças em séries desde 2019.',
      followers: 980,
      following: 103,
    ),

    Profile(
      id: 3,
      name: 'Amy Winehouse',
      photoUrl: 'https://akamai.sscdn.co/uploadfile/letras/fotos/f/1/c/f/f1cf6f9da728c1d80f09b881bd244bca.jpg',
      bio: 'Tentando não voltar pras drogas....',
      followers: 2100,
      following: 580,
    ),
  ];

  Future<List<Profile>> getProfiles() async {
    return _profiles;
  }

  Future<void> updateProfile(Profile updatedProfile) async {
    final index = _profiles.indexWhere((profile) => profile.id == updatedProfile.id);

    if (index != -1) {
      _profiles[index] = updatedProfile;
    }
  }
}