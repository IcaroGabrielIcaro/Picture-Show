import 'package:flutter/material.dart';
import 'package:picture_show/theme/app_colors.dart';
import 'package:picture_show/widgets/navigation/bottom_navigation.dart';
import 'package:picture_show/widgets/navigation/navigation_tab.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final NavigationTab currentTab;
  final Color backgroundColor;
  final bool showNavigation;

  const AppScaffold({
    super.key,
    required this.child,
    required this.currentTab,
    this.appBar,
    this.backgroundColor = AppColors.background,
    this.showNavigation = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: SafeArea(top: appBar == null, bottom: false, child: child),
      bottomNavigationBar: showNavigation
          ? AppBottomNavigation(currentTab: currentTab)
          : null,
    );
  }
}
