import 'package:picture_show/features/feed/models/publicacao.dart';

/// Representa uma resposta paginada da listagem de publicações.
class PublicacoesResponse {
  /// Quantidade total de registros.
  final int count;

  /// URL da próxima página.
  final String? next;

  /// URL da página anterior.
  final String? previous;

  /// Publicações retornadas.
  final List<Publicacao> results;

  const PublicacoesResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  /// Cria uma instância a partir do JSON.
  factory PublicacoesResponse.fromJson(Map<String, dynamic> json) {
    return PublicacoesResponse(
      count: json['count'] as int? ?? 0,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>? ?? [])
          .map((e) => Publicacao.fromJson(e))
          .toList(),
    );
  }

  /// Converte para JSON.
  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((e) => e.toJson()).toList(),
    };
  }

  /// Indica se existe uma próxima página.
  bool get hasNext => next != null;

  /// Indica se existe uma página anterior.
  bool get hasPrevious => previous != null;

  @override
  String toString() {
    return 'PublicacoesResponse(count: $count, results: ${results.length})';
  }
}
