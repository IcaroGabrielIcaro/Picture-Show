import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picture_show/theme/app_colors.dart';
import 'package:picture_show/theme/app_durations.dart';
import 'package:picture_show/theme/app_radius.dart';
import 'package:picture_show/theme/app_text_styles.dart';
import 'package:picture_show/theme/app_spacing.dart';
import 'package:picture_show/widgets/navigation/navigation_tab.dart';

class AppBottomNavigation extends StatelessWidget {
  final NavigationTab currentTab;

  const AppBottomNavigation({super.key, required this.currentTab});

  void _navigate(BuildContext context, NavigationTab tab) {
    if (tab == currentTab) return;

    context.go(tab.route);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 76,
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .04),
              blurRadius: 18,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _NavigationItem(
                icon: Icons.home_outlined,
                selectedIcon: Icons.home,
                label: 'Feed',
                selected: currentTab == NavigationTab.feed,
                onTap: () => _navigate(context, NavigationTab.feed),
              ),
            ),

            Expanded(
              child: _NavigationItem(
                icon: Icons.search_outlined,
                selectedIcon: Icons.search,
                label: 'Buscar',
                selected: currentTab == NavigationTab.search,
                onTap: () => _navigate(context, NavigationTab.search),
              ),
            ),

            Expanded(
              child: _CreateButton(
                selected: currentTab == NavigationTab.create,
                onTap: () => _navigate(context, NavigationTab.create),
              ),
            ),

            Expanded(
              child: _NavigationItem(
                icon: Icons.favorite_border,
                selectedIcon: Icons.favorite,
                label: 'Notificações',
                selected: currentTab == NavigationTab.notifications,
                onTap: () => _navigate(context, NavigationTab.notifications),
              ),
            ),

            Expanded(
              child: _NavigationItem(
                icon: Icons.person_outline,
                selectedIcon: Icons.person,
                label: 'Perfil',
                selected: currentTab == NavigationTab.profile,
                onTap: () => _navigate(context, NavigationTab.profile),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavigationItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textSecondary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: AnimatedContainer(
        duration: AppDurations.normal,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: AppDurations.fast,
              child: Icon(
                selected ? selectedIcon : icon,
                key: ValueKey(selected),
                color: color,
                size: 27,
              ),
            ),

            const SizedBox(height: 4),

            AnimatedDefaultTextStyle(
              duration: AppDurations.fast,
              style: AppTextStyles.caption.copyWith(
                color: color,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;

  const _CreateButton({required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: AnimatedContainer(
          duration: AppDurations.normal,
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(
                  alpha: selected ? .45 : .25,
                ),
                blurRadius: selected ? 18 : 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 32),
        ),
      ),
    );
  }
}
