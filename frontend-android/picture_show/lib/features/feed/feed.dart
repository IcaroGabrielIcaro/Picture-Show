import 'package:flutter/material.dart';
import 'package:picture_show/features/feed/feed_provider.dart';
import 'package:picture_show/features/feed/feed_state.dart';
import 'package:picture_show/features/feed/widgets/publicacao_card.dart';
import 'package:picture_show/theme/app_colors.dart';
import 'package:picture_show/theme/app_spacing.dart';
import 'package:picture_show/widgets/feedback/feedback_builder.dart';
import 'package:picture_show/widgets/header/header.dart';
import 'package:provider/provider.dart';

/// Tela responsável por exibir o feed de publicações.
///
/// Toda a obtenção dos dados é realizada pelo [FeedProvider].
class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FeedProvider>().carregarFeed();
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    const limite = 300;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - limite) {
      context.read<FeedProvider>().carregarMais();
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FeedProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const Header(title: 'Picture Show'),
      body: SafeArea(
        child: switch (provider.state.status) {
          FeedStatus.loading => const Center(
            child: CircularProgressIndicator(),
          ),

          FeedStatus.error => FeedbackBuilder.fromError(
            error: provider.state.errorType,
            onRetry: provider.carregarFeed,
          ),

          _ => RefreshIndicator(
            onRefresh: provider.atualizar,
            child: provider.state.publicacoes.isEmpty
                ? const _EmptyFeed()
                : ListView.separated(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount:
                        provider.state.publicacoes.length +
                        (provider.state.carregandoMais ? 1 : 0),
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      if (index == provider.state.publicacoes.length) {
                        return const Padding(
                          padding: EdgeInsets.all(AppSpacing.md),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      return PublicacaoCard(
                        publicacao: provider.state.publicacoes[index],
                      );
                    },
                  ),
          ),
        },
      ),
    );
  }
}

class _EmptyFeed extends StatelessWidget {
  const _EmptyFeed();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.photo_library_outlined,
                    size: 64,
                    color: AppColors.textSecondary,
                  ),

                  const SizedBox(height: AppSpacing.md),

                  Text(
                    'Nenhuma publicação encontrada.',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  Text(
                    'Quando alguém compartilhar uma foto ela aparecerá aqui.\n\n'
                    'Deslize para baixo para atualizar.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
