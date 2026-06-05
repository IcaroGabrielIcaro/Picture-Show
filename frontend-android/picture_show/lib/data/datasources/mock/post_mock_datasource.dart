import 'package:picture_show/data/datasources/mock/profile_mock_datasource.dart';
import 'package:picture_show/features/post/entities/post.dart';

class PostMockDatasource {
  final ProfileMockDatasource profileDatasource;

  PostMockDatasource(this.profileDatasource);

  Future<List<Post>> getPosts() async {
    final profiles = await profileDatasource.getProfiles();

    return [
      Post(
        author: profiles[0],
        imagePath: 'lib/assets/images/davi-001.jpeg',
        description: 'Filmando mais um clássico questionável.',
        publishedAt: 'Há 10 minutos',
        likes: 15,
        isLiked: false,
      ),

      Post(
        author: profiles[1],
        imagePath: 'lib/assets/images/davi-002.jpeg',
        description: 'Às vezes o melhor plano é não ter plano.',
        publishedAt: 'Há 18 minutos',
        likes: 42,
        isLiked: false,
      ),

      Post(
        author: profiles[2],
        imagePath: 'lib/assets/images/davi-003.jpeg',
        description: 'Mais uma missão concluída.',
        publishedAt: 'Há 30 minutos',
        likes: 67,
        isLiked: true,
      ),

      Post(
        author: profiles[3],
        imagePath: 'lib/assets/images/davi-004.jpeg',
        description: 'Luz boa, câmera pronta e momento perfeito.',
        publishedAt: 'Há 45 minutos',
        likes: 31,
        isLiked: false,
      ),

      Post(
        author: profiles[0],
        imagePath: 'lib/assets/images/davi-005.jpeg',
        description: 'Isso parecia uma boa ideia na minha cabeça.',
        publishedAt: 'Há 1 hora',
        likes: 54,
        isLiked: false,
      ),

      Post(
        author: profiles[1],
        imagePath: 'lib/assets/images/davi-006.jpeg',
        description: 'A vida continua carregando...',
        publishedAt: 'Há 1 hora',
        likes: 83,
        isLiked: true,
      ),

      Post(
        author: profiles[2],
        imagePath: 'lib/assets/images/davi-007.jpeg',
        description: 'Explorando novos caminhos.',
        publishedAt: 'Há 2 horas',
        likes: 91,
        isLiked: false,
      ),

      Post(
        author: profiles[3],
        imagePath: 'lib/assets/images/davi-008.jpeg',
        description: 'Uma das minhas capturas favoritas da semana.',
        publishedAt: 'Há 2 horas',
        likes: 48,
        isLiked: false,
      ),

      Post(
        author: profiles[0],
        imagePath: 'lib/assets/images/davi-009.jpeg',
        description: 'Não me perguntem como chegamos aqui.',
        publishedAt: 'Há 3 horas',
        likes: 74,
        isLiked: true,
      ),

      Post(
        author: profiles[1],
        imagePath: 'lib/assets/images/davi-010.jpeg',
        description: 'Respirando fundo e seguindo em frente.',
        publishedAt: 'Há 3 horas',
        likes: 102,
        isLiked: false,
      ),

      Post(
        author: profiles[2],
        imagePath: 'lib/assets/images/davi-011.jpeg',
        description: 'Aventura desbloqueada.',
        publishedAt: 'Há 4 horas',
        likes: 88,
        isLiked: false,
      ),

      Post(
        author: profiles[3],
        imagePath: 'lib/assets/images/davi-012.jpeg',
        description: 'Mais um registro para a coleção.',
        publishedAt: 'Há 5 horas',
        likes: 65,
        isLiked: true,
      ),

      Post(
        author: profiles[0],
        imagePath: 'lib/assets/images/davi-013.jpeg',
        description: 'Definitivamente aconteceu.',
        publishedAt: 'Há 6 horas',
        likes: 57,
        isLiked: false,
      ),

      Post(
        author: profiles[1],
        imagePath: 'lib/assets/images/davi-014.jpeg',
        description: 'Vivendo um dia de cada vez.',
        publishedAt: 'Há 6 horas',
        likes: 120,
        isLiked: true,
      ),

      Post(
        author: profiles[2],
        imagePath: 'lib/assets/images/davi-015.jpeg',
        description: 'Só observando o cenário.',
        publishedAt: 'Há 7 horas',
        likes: 73,
        isLiked: false,
      ),

      Post(
        author: profiles[3],
        imagePath: 'lib/assets/images/davi-016.jpeg',
        description: 'Um clique simples que gostei bastante.',
        publishedAt: 'Há 8 horas',
        likes: 39,
        isLiked: false,
      ),

      Post(
        author: profiles[0],
        imagePath: 'lib/assets/images/davi-017.jpeg',
        description: 'Caos organizado.',
        publishedAt: 'Há 9 horas',
        likes: 46,
        isLiked: true,
      ),

      Post(
        author: profiles[1],
        imagePath: 'lib/assets/images/davi-018.jpeg',
        description: 'Ainda tentando entender tudo isso.',
        publishedAt: 'Há 10 horas',
        likes: 131,
        isLiked: false,
      ),

      Post(
        author: profiles[2],
        imagePath: 'lib/assets/images/davi-019.jpeg',
        description: 'Valeu a caminhada.',
        publishedAt: 'Há 11 horas',
        likes: 92,
        isLiked: true,
      ),

      Post(
        author: profiles[3],
        imagePath: 'lib/assets/images/davi-020.jpeg',
        description: 'Fotografia é sobre encontrar momentos.',
        publishedAt: 'Há 12 horas',
        likes: 58,
        isLiked: false,
      ),

      Post(
        author: profiles[0],
        imagePath: 'lib/assets/images/davi-021.jpeg',
        description: 'Ninguém estava preparado para isso.',
        publishedAt: 'Há 13 horas',
        likes: 81,
        isLiked: false,
      ),

      Post(
        author: profiles[1],
        imagePath: 'lib/assets/images/davi-022.jpeg',
        description: 'Silêncio também é resposta.',
        publishedAt: 'Há 14 horas',
        likes: 99,
        isLiked: true,
      ),

      Post(
        author: profiles[2],
        imagePath: 'lib/assets/images/davi-023.jpeg',
        description: 'Dia produtivo.',
        publishedAt: 'Há 15 horas',
        likes: 66,
        isLiked: false,
      ),

      Post(
        author: profiles[3],
        imagePath: 'lib/assets/images/davi-024.jpeg',
        description: 'Um dos lugares mais bonitos que visitei.',
        publishedAt: 'Há 16 horas',
        likes: 143,
        isLiked: true,
      ),

      Post(
        author: profiles[0],
        imagePath: 'lib/assets/images/davi-025.jpeg',
        description: 'Mais uma história para contar.',
        publishedAt: 'Há 17 horas',
        likes: 53,
        isLiked: false,
      ),

      Post(
        author: profiles[1],
        imagePath: 'lib/assets/images/davi-026.jpeg',
        description: 'Sem filtros, sem complicação.',
        publishedAt: 'Há 18 horas',
        likes: 117,
        isLiked: false,
      ),

      Post(
        author: profiles[2],
        imagePath: 'lib/assets/images/davi-027.jpeg',
        description: 'Treinamento concluído.',
        publishedAt: 'Há 19 horas',
        likes: 95,
        isLiked: true,
      ),

      Post(
        author: profiles[3],
        imagePath: 'lib/assets/images/davi-028.jpeg',
        description: 'Gostei da composição dessa foto.',
        publishedAt: 'Há 20 horas',
        likes: 44,
        isLiked: false,
      ),

      Post(
        author: profiles[0],
        imagePath: 'lib/assets/images/davi-029.jpeg',
        description: 'Nada pode dar errado. Acho.',
        publishedAt: 'Há 21 horas',
        likes: 89,
        isLiked: true,
      ),

      Post(
        author: profiles[1],
        imagePath: 'lib/assets/images/davi-030.jpeg',
        description: 'Mais um capítulo da jornada.',
        publishedAt: 'Há 22 horas',
        likes: 109,
        isLiked: false,
      ),

      Post(
        author: profiles[2],
        imagePath: 'lib/assets/images/davi-031.jpeg',
        description: 'Continuamos avançando.',
        publishedAt: 'Há 23 horas',
        likes: 77,
        isLiked: true,
      ),

      Post(
        author: profiles[3],
        imagePath: 'lib/assets/images/davi-032.jpeg',
        description: 'Encerrando o dia com essa foto.',
        publishedAt: 'Há 1 dia',
        likes: 62,
        isLiked: false,
      ),

      Post(
        author: profiles[3],
        imagePath: 'lib/assets/images/gui-001.jpeg',
        description: 'Começando a semana com energia.',
        publishedAt: 'Há 1 dia',
        likes: 71,
        isLiked: false,
      ),

      Post(
        author: profiles[2],
        imagePath: 'lib/assets/images/gui-002.jpeg',
        description: 'Missão secundária aceita.',
        publishedAt: 'Há 1 dia',
        likes: 87,
        isLiked: true,
      ),

      Post(
        author: profiles[1],
        imagePath: 'lib/assets/images/gui-003.jpeg',
        description: 'A melhor vista é a próxima.',
        publishedAt: 'Há 1 dia',
        likes: 133,
        isLiked: false,
      ),

      Post(
        author: profiles[0],
        imagePath: 'lib/assets/images/gui-004.jpeg',
        description: 'Não tentem reproduzir isso.',
        publishedAt: 'Há 2 dias',
        likes: 59,
        isLiked: true,
      ),

      Post(
        author: profiles[3],
        imagePath: 'lib/assets/images/gui-005.jpeg',
        description: 'Um instante congelado no tempo.',
        publishedAt: 'Há 2 dias',
        likes: 94,
        isLiked: false,
      ),

      Post(
        author: profiles[2],
        imagePath: 'lib/assets/images/gui-006.jpeg',
        description: 'Pequenas vitórias importam.',
        publishedAt: 'Há 2 dias',
        likes: 68,
        isLiked: true,
      ),

      Post(
        author: profiles[1],
        imagePath: 'lib/assets/images/gui-007.jpeg',
        description: 'Só curtindo o momento.',
        publishedAt: 'Há 2 dias',
        likes: 124,
        isLiked: false,
      ),

      Post(
        author: profiles[0],
        imagePath: 'lib/assets/images/gui-008.jpeg',
        description: 'Mais estranho do que parece.',
        publishedAt: 'Há 3 dias',
        likes: 72,
        isLiked: false,
      ),

      Post(
        author: profiles[2],
        imagePath: 'lib/assets/images/igo-001.jpeg',
        description: 'Novo destino desbloqueado.',
        publishedAt: 'Há 3 dias',
        likes: 96,
        isLiked: true,
      ),

      Post(
        author: profiles[3],
        imagePath: 'lib/assets/images/igo-002.jpeg',
        description: 'Um café e boas ideias.',
        publishedAt: 'Há 3 dias',
        likes: 57,
        isLiked: false,
      ),

      Post(
        author: profiles[1],
        imagePath: 'lib/assets/images/igo-003.jpeg',
        description: 'Pensamentos aleatórios da madrugada.',
        publishedAt: 'Há 4 dias',
        likes: 146,
        isLiked: true,
      ),

      Post(
        author: profiles[3],
        imagePath: 'lib/assets/images/kaue-001.jpeg',
        description: 'Lugares simples rendem boas histórias.',
        publishedAt: 'Há 4 dias',
        likes: 63,
        isLiked: false,
      ),

      Post(
        author: profiles[2],
        imagePath: 'lib/assets/images/kaue-002.jpeg',
        description: 'Seguimos explorando.',
        publishedAt: 'Há 4 dias',
        likes: 82,
        isLiked: true,
      ),

      Post(
        author: profiles[1],
        imagePath: 'lib/assets/images/kaue-003.jpeg',
        description: 'Nada além do essencial.',
        publishedAt: 'Há 5 dias',
        likes: 111,
        isLiked: false,
      ),

      Post(
        author: profiles[0],
        imagePath: 'lib/assets/images/kaue-004.jpeg',
        description: 'Provavelmente uma péssima ideia.',
        publishedAt: 'Há 5 dias',
        likes: 69,
        isLiked: true,
      ),

      Post(
        author: profiles[3],
        imagePath: 'lib/assets/images/kaue-005.jpeg',
        description: 'Fechando a galeria com chave de ouro.',
        publishedAt: 'Há 5 dias',
        likes: 91,
        isLiked: false,
      ),

      Post(
        author: profiles[2],
        imagePath: 'lib/assets/images/vito-001.jpeg',
        description: 'Último registro da semana.',
        publishedAt: 'Há 6 dias',
        likes: 103,
        isLiked: true,
      ),
    ];
  }
}