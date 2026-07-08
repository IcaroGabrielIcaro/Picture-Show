import 'package:flutter/material.dart';
import 'package:picture_show/features/feed/feed_provider.dart';
import 'package:picture_show/features/feed/feed_state.dart';
import 'package:picture_show/features/feed/widgets/publicacao_card.dart';
import 'package:picture_show/theme/app_colors.dart';
import 'package:picture_show/theme/app_radius.dart';
import 'package:picture_show/theme/app_spacing.dart';
import 'package:picture_show/theme/app_text_styles.dart';
import 'package:picture_show/widgets/feedback/feedback_builder.dart';
import 'package:picture_show/widgets/header/header.dart';
import 'package:picture_show/widgets/layout/app_scaffold.dart';
import 'package:picture_show/widgets/navigation/navigation_tab.dart';
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

    // As telas de feedback ocupam a tela inteira.
    if (provider.state.status == FeedStatus.error) {
      return FeedbackBuilder.fromError(
        error: provider.state.errorType,
        onRetry: provider.carregarFeed,
      );
    }

    return AppScaffold(
      currentTab: NavigationTab.feed,

      appBar: const Header(title: 'Picture Show'),

      child: switch (provider.state.status) {
        FeedStatus.loading => const Center(child: CircularProgressIndicator()),

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
    );
  }
}

class _EmptyFeed extends StatelessWidget {
  const _EmptyFeed();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: constraints.maxHeight,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Icon(
                          Icons.photo_library_outlined,
                          size: 42,
                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      Text(
                        'Seu feed ainda está vazio',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.logo.copyWith(
                          fontSize: 24,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.md),

                      Text(
                        'Assim que você ou outras pessoas compartilharem fotos, elas aparecerão aqui.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                          vertical: AppSpacing.md,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadius.xl),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.south,
                              size: 18,
                              color: AppColors.primary,
                            ),

                            const SizedBox(width: AppSpacing.sm),

                            Text(
                              'Deslize para baixo para atualizar',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
