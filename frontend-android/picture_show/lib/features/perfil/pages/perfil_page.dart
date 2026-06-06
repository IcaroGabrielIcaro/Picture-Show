import 'package:flutter/material.dart';
import 'package:picture_show/core/widgets/app_drawer.dart';
import 'package:picture_show/core/widgets/edit_profile_sheet.dart';
import 'package:picture_show/features/perfil/entities/profile.dart';
import 'package:picture_show/features/perfil/providers/profile_provider.dart';
import 'package:picture_show/features/post/providers/post_provider.dart';
import 'package:picture_show/shared/widgets/headers/page_header.dart';
import '../widgets/perfil_info_section.dart';
import '../widgets/perfil_posts_grid.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatelessWidget {

  final Profile profile;

  const PerfilPage({
    super.key,
    required this.profile,
  });
    
  @override
  Widget build(BuildContext context) {

    final profileProvider = context.watch<ProfileProvider>();
    final currentProfile = profileProvider.getProfileById(profile.id);

    if (currentProfile == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final postProvider = context.watch<PostProvider>();
    final profilePosts = postProvider.getPostsByProfileId(currentProfile.id);

    return Scaffold(

      endDrawer: currentProfile.id == 0
        ? const AppDrawer()
        : null,

      backgroundColor: const Color(0xFFFFFEEF),

      body: SafeArea(

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: PageHeader(
                nome: currentProfile.name,
                action: currentProfile.id == 0 ? Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: const Icon(Icons.menu)
                    );
                  }
                ) : const SizedBox.shrink(),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(

                child: Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 16),

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Divider(
                        color: Color(0xFF3C3535),
                        thickness: 1,
                      ),

                      SizedBox(height: 12),

                      PerfilInfoSection(
                        profile: currentProfile,
                        totalPosts: profilePosts.length,
                        onEditProfile: () async {

                          final profileProvider =
                              context.read<ProfileProvider>();

                          final result = await showModalBottomSheet<Map<String, String>>(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            barrierColor: Colors.black54,
                            builder: (_) => EditProfileSheet(
                              profile: currentProfile,
                            ),
                          );

                          if (result != null) {

                            profileProvider.updateProfile(
                              id: currentProfile.id,
                              name: result['name'] ?? currentProfile.name,
                              bio: result['bio'] ?? currentProfile.bio,
                            );

                          }

                        },
                      ),

                      SizedBox(height: 12),

                      Divider(
                        color: Color(0xFFD0D0D0),
                        thickness: 1,
                      ),

                      SizedBox(height: 12),

                      PerfilPostsGrid(
                        profile: currentProfile,
                        posts: profilePosts,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}