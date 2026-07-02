import 'package:picture_show/models/usuario_response_model.dart';

/// Representa uma publicação exibida no feed.
class Publicacao {
  /// Identificador da publicação.
  final int id;

  /// Texto da publicação.
  final String descricao;

  /// URL da imagem publicada.
  final String imagem;

  /// Autor da publicação.
  final Usuario autor;

  /// Quantidade de curtidas.
  final int likes;

  /// Quantidade de descurtidas.
  final int dislikes;

  /// Quantidade de comentários.
  final int comentarios;

  /// Reação do usuário autenticado.
  ///
  /// Exemplos:
  /// - like
  /// - dislike
  /// - null
  final String? minhaReacao;

  /// Data de publicação.
  final DateTime publicadoEm;

  const Publicacao({
    required this.id,
    required this.descricao,
    required this.imagem,
    required this.autor,
    required this.likes,
    required this.dislikes,
    required this.comentarios,
    this.minhaReacao,
    required this.publicadoEm,
  });

  /// Cria uma instância a partir do JSON.
  factory Publicacao.fromJson(Map<String, dynamic> json) {
    return Publicacao(
      id: json['id'] as int,
      descricao: json['descricao'] as String? ?? '',
      imagem: json['imagem'] as String? ?? '',
      autor: Usuario.fromJson(json['autor']),
      likes: int.tryParse(json['likes'].toString()) ?? 0,
      dislikes: int.tryParse(json['dislikes'].toString()) ?? 0,
      comentarios: int.tryParse(json['comentarios'].toString()) ?? 0,
      minhaReacao: json['minha_reacao'] as String?,
      publicadoEm: DateTime.parse(json['publicado_em']),
    );
  }

  /// Converte para JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'imagem': imagem,
      'autor': autor.toJson(),
      'likes': likes,
      'dislikes': dislikes,
      'comentarios': comentarios,
      'minha_reacao': minhaReacao,
      'publicado_em': publicadoEm.toIso8601String(),
    };
  }

  /// Cria uma cópia alterando apenas os campos desejados.
  Publicacao copyWith({
    int? id,
    String? descricao,
    String? imagem,
    Usuario? autor,
    int? likes,
    int? dislikes,
    int? comentarios,
    String? minhaReacao,
    DateTime? publicadoEm,
  }) {
    return Publicacao(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      imagem: imagem ?? this.imagem,
      autor: autor ?? this.autor,
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
      comentarios: comentarios ?? this.comentarios,
      minhaReacao: minhaReacao ?? this.minhaReacao,
      publicadoEm: publicadoEm ?? this.publicadoEm,
    );
  }

  @override
  String toString() {
    return 'Publicacao(id: $id, autor: ${autor.username})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Publicacao &&
        other.id == id &&
        other.descricao == descricao &&
        other.imagem == imagem &&
        other.autor == autor &&
        other.likes == likes &&
        other.dislikes == dislikes &&
        other.comentarios == comentarios &&
        other.minhaReacao == minhaReacao &&
        other.publicadoEm == publicadoEm;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      descricao,
      imagem,
      autor,
      likes,
      dislikes,
      comentarios,
      minhaReacao,
      publicadoEm,
    );
  }

  /// Data formatada para exibição.
  String get publicadoEmFormatado {
    final agora = DateTime.now();
    final diferenca = agora.difference(publicadoEm);

    if (diferenca.inMinutes < 1) {
      return 'Agora';
    }

    if (diferenca.inHours < 1) {
      return '${diferenca.inMinutes} min';
    }

    if (diferenca.inDays < 1) {
      return '${diferenca.inHours} h';
    }

    if (diferenca.inDays < 30) {
      return '${diferenca.inDays} d';
    }

    if (diferenca.inDays < 365) {
      return '${(diferenca.inDays / 30).floor()} mês';
    }

    return '${(diferenca.inDays / 365).floor()} ano';
  }
}
