import '../entities/post.dart';
import '../../perfil/mock/profiles_mock.dart';

final List<Post> postsMock = [
  Post(
    author: profilesMock[0],
    imageUrl: 'https://images.genius.com/1fa2efe03d7343dd8781734626e5a98b.1000x1000x1.png',
    description: 'Pense numa banda de caba macho',
    publishedAt: 'Há 3 horas',
    likes: 6,
    isLiked: false,
  ),

  Post(
    author: profilesMock[1],
    imageUrl: 'https://tse1.mm.bing.net/th/id/OIP.Hr51If6vS5vPsq6rwbQnqwHaLH?cb=thfc1falcon&pid=ImgDet&w=203&h=304&c=7&o=7&rm=3',
    description: 'Bom dia galera',
    publishedAt: 'Há 1 hora',
    likes: 12,
    isLiked: true,
  ),

  Post(
    author: profilesMock[2],
    imageUrl: 'https://i.ytimg.com/vi/FA83gaMatV8/maxresdefault.jpg',
    description: 'This is the way.',
    publishedAt: 'Há 30 minutos',
    likes: 128,
    isLiked: false,
  ),
];
