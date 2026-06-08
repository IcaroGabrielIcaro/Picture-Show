import 'package:flutter/material.dart';
import 'package:picture_show/features/perfil/entities/profile.dart';
import 'package:picture_show/shared/theme/app_text_styles.dart';
import 'package:picture_show/shared/widgets/buttons/custom_button.dart';
import 'perfil_stats.dart';

class PerfilInfoSection extends StatelessWidget {

  final Profile profile;
  final int totalPosts;

  final Future<void> Function()? onEditProfile;

  const PerfilInfoSection({
    super.key,
    required this.profile,
    required this.totalPosts,
    this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {

    final isMyProfile = profile.id == 0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth > 600;

        final double avatarRadius = isLargeScreen ? 104 : 52;
        final double titleSize = isLargeScreen ? 32 : 24;
        final double descriptionSize = isLargeScreen ? 24 : 16;
        final double buttonTextSize = isLargeScreen ? 24 : 16;

        return Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Opacity(
                  opacity: 0.8,
                  child: CircleAvatar(
                    radius: avatarRadius,
                    backgroundImage: NetworkImage(
                      profile.photoUrl,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(profile.name, style: AppTextStyles.heading.copyWith(fontSize: titleSize)),
                      Text(profile.bio, style: AppTextStyles.body.copyWith(fontSize: descriptionSize))
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            PerfilStats(
              isLargeScreen: isLargeScreen, 
              profile: profile,
              totalPosts: totalPosts,
            ),

            const SizedBox(height: 12),

            CustomButton(
              text: isMyProfile ? 'Editar perfil' : 'Seguir',
              type: isMyProfile ? ButtonType.secondary : ButtonType.primary,
              fontSize: buttonTextSize,
              onPressed: isMyProfile ? onEditProfile : () {},
            )
          ],

        );
      },
    );
  }
}