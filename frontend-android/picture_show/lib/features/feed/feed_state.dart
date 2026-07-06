import 'package:picture_show/features/feed/models/publicacao.dart';

enum FeedStatus { initial, loading, success, error }

enum FeedErrorType { network, server, unknown }

class FeedState {
  final FeedStatus status;
  final List<Publicacao> publicacoes;
  final bool carregandoMais;
  final bool possuiMaisPaginas;

  final FeedErrorType? errorType;
  final String? message;

  const FeedState({
    this.status = FeedStatus.initial,
    this.publicacoes = const [],
    this.carregandoMais = false,
    this.possuiMaisPaginas = true,
    this.errorType,
    this.message,
  });

  FeedState copyWith({
    FeedStatus? status,
    List<Publicacao>? publicacoes,
    bool? carregandoMais,
    bool? possuiMaisPaginas,
    FeedErrorType? errorType,
    String? message,
  }) {
    return FeedState(
      status: status ?? this.status,
      publicacoes: publicacoes ?? this.publicacoes,
      carregandoMais: carregandoMais ?? this.carregandoMais,
      possuiMaisPaginas: possuiMaisPaginas ?? this.possuiMaisPaginas,
      errorType: errorType ?? this.errorType,
      message: message ?? this.message,
    );
  }
}
