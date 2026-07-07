import 'package:flutter/material.dart';
import 'package:picture_show/theme/app_colors.dart';
import 'package:picture_show/theme/app_spacing.dart';
import 'package:picture_show/theme/app_text_styles.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  final Widget? leading;
  final List<Widget>? actions;

  final bool centerTitle;
  final bool showBottomBorder;

  const Header({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.showBottomBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: leading,
      actions: actions,

      elevation: 0,
      scrolledUnderElevation: 0,

      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,

      centerTitle: centerTitle,

      title: Text(
        title,
        style: AppTextStyles.logo.copyWith(
          fontSize: 26,
          color: AppColors.primary,
          letterSpacing: 0.6,
        ),
      ),

      bottom: showBottomBorder
          ? PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                color: AppColors.border.withValues(alpha: 0.6)
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
