import 'package:flutter/material.dart';
import 'package:picture_show/core/exceptions/api_exception.dart';
import 'package:picture_show/features/feed/feed_repository.dart';
import 'package:picture_show/features/feed/feed_state.dart';

class FeedProvider extends ChangeNotifier {
  final FeedRepository repository;

  FeedProvider(this.repository);

  FeedState _state = const FeedState();
  FeedState get state => _state;

  int _paginaAtual = 1;

  Future<void> carregarFeed() async {
    _paginaAtual = 1;

    _state = _state.copyWith(
      status: FeedStatus.loading,
      publicacoes: [],
      possuiMaisPaginas: true,
      message: null,
    );

    notifyListeners();

    try {
      final publicacoes = await repository.listarFeed(page: _paginaAtual);

      _state = _state.copyWith(
        status: FeedStatus.success,
        publicacoes: publicacoes,
        possuiMaisPaginas: publicacoes.isNotEmpty,
      );
    } on ApiException catch (e) {
      _state = _state.copyWith(
        status: FeedStatus.error,
        errorType: e.type,
        message: e.message,
      );
    } catch (_) {
      _state = _state.copyWith(
        status: FeedStatus.error,
        errorType: ApiErrorType.unknown,
        message: 'Erro inesperado.',
      );
    }

    notifyListeners();
  }

  Future<void> carregarMais() async {
    if (_state.carregandoMais || !_state.possuiMaisPaginas) return;

    _state = _state.copyWith(carregandoMais: true);
    notifyListeners();

    try {
      final publicacoes = await repository.listarFeed(page: ++_paginaAtual);

      _state = _state.copyWith(
        carregandoMais: false,
        publicacoes: [..._state.publicacoes, ...publicacoes],
        possuiMaisPaginas: publicacoes.isNotEmpty,
      );
    } catch (e) {
      _paginaAtual--;

      _state = _state.copyWith(carregandoMais: false, message: e.toString());
    }

    notifyListeners();
  }

  Future<void> atualizar() async {
    await carregarFeed();
  }
}
