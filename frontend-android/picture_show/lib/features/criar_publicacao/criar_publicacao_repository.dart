import 'dart:io';

import 'package:picture_show/features/criar_publicacao/criar_publicacao_service.dart';
import 'package:picture_show/models/publicacao.dart';

class CriarPublicacaoRepository {
  final CriarPublicacaoService api;

  const CriarPublicacaoRepository({required this.api});

  Future<Publicacao> criarPublicacao({
    required File imagem,
    required String descricao,
  }) {
    return api.criarPublicacao(imagem: imagem, descricao: descricao);
  }
}
