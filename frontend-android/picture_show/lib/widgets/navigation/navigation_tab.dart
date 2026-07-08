enum NavigationTab { feed, search, create, notifications, profile }

extension NavigationTabExtension on NavigationTab {
  String get route => switch (this) {
    NavigationTab.feed => '/feed',
    NavigationTab.search => '/buscar',
    NavigationTab.create => '/publicar',
    NavigationTab.notifications => '/notificacoes',
    NavigationTab.profile => '/perfil',
  };
}
