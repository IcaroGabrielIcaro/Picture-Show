import 'package:picture_show/features/feed/models/publicacao.dart';

enum FeedStatus { initial, loading, success, error }

class FeedState {
  final FeedStatus status;
  final List<Publicacao> publicacoes;
  final bool carregandoMais;
  final bool possuiMaisPaginas;
  final String? message;

  const FeedState({
    this.status = FeedStatus.initial,
    this.publicacoes = const [],
    this.carregandoMais = false,
    this.possuiMaisPaginas = true,
    this.message,
  });

  FeedState copyWith({
    FeedStatus? status,
    List<Publicacao>? publicacoes,
    bool? carregandoMais,
    bool? possuiMaisPaginas,
    String? message,
  }) {
    return FeedState(
      status: status ?? this.status,
      publicacoes: publicacoes ?? this.publicacoes,
      carregandoMais: carregandoMais ?? this.carregandoMais,
      possuiMaisPaginas: possuiMaisPaginas ?? this.possuiMaisPaginas,
      message: message,
    );
  }
}
