import 'package:flutter/material.dart';
import 'package:picture_show/core/exceptions/api_exception.dart';
import 'package:picture_show/features/feed/feed_service.dart';
import 'package:picture_show/features/feed/feed_state.dart';

class FeedProvider extends ChangeNotifier {
  final FeedService service;

  FeedProvider(this.service);

  FeedState _state = const FeedState();

  FeedState get state => _state;

  int _paginaAtual = 1;

  /// Carrega a primeira página.
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
      final response = await service.listarPublicacoes(page: _paginaAtual);

      _state = _state.copyWith(
        status: FeedStatus.success,
        publicacoes: response.results,
        possuiMaisPaginas: response.next != null,
      );
    } on ApiException catch (e) {
      _state = _state.copyWith(status: FeedStatus.error, message: e.message);
    }

    notifyListeners();
  }

  /// Busca a próxima página do feed.
  Future<void> carregarMais() async {
    if (_state.carregandoMais) return;

    if (!_state.possuiMaisPaginas) return;

    _state = _state.copyWith(carregandoMais: true);

    notifyListeners();

    try {
      final response = await service.listarPublicacoes(page: ++_paginaAtual);

      _state = _state.copyWith(
        carregandoMais: false,
        publicacoes: [..._state.publicacoes, ...response.results],
        possuiMaisPaginas: response.next != null,
      );
    } on ApiException catch (e) {
      _paginaAtual--;

      _state = _state.copyWith(carregandoMais: false, message: e.message);
    }

    notifyListeners();
  }

  /// Atualiza o feed (pull-to-refresh).
  Future<void> atualizar() async {
    await carregarFeed();
  }
}
