import 'package:flutter/material.dart';
import 'package:picture_show/core/widgets/app_drawer.dart';
import 'package:picture_show/core/widgets/edit_profile_sheet.dart';
import 'package:picture_show/features/perfil/entities/profile.dart';
import 'package:picture_show/shared/mock/posts_mock.dart';
import 'package:picture_show/shared/widgets/headers/page_header.dart';
import 'widgets/perfil_info_section.dart';
import 'widgets/perfil_posts_grid.dart';

class PerfilPage extends StatefulWidget {

  final Profile profile;

  const PerfilPage({
    super.key,
    required this.profile,
  });

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {

  late String name;
  late String bio;

  @override
  void initState() {
    super.initState();

    name = widget.profile.name;
    bio = widget.profile.bio;
  }

  @override
  Widget build(BuildContext context) {

    final profilePosts = postsMock
      .where((post) => post.author.id == widget.profile.id)
      .toList();

    return Scaffold(

      endDrawer: widget.profile.id == 0
        ? const AppDrawer()
        : null,

      backgroundColor: const Color(0xFFFFFEEF),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(

            padding: const EdgeInsets.all(16),

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                PageHeader(
                  nome: widget.profile.name,
                  action: widget.profile.id == 0 ? Builder(
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

                SizedBox(height: 12),

                Divider(
                  color: Color(0xFF3C3535),
                  thickness: 1,
                ),

                SizedBox(height: 12),

                PerfilInfoSection(
                  profile: widget.profile,
                  totalPosts: profilePosts.length,

                  displayName: name,
                  displayBio: bio,

                  onEditProfile: () async {

                    final result = await showModalBottomSheet<Map<String, String>>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.black54,
                      builder: (_) => EditProfileSheet(
                        profile: widget.profile,
                      ),
                    );

                    print(result);

                    if (result != null) {

                      setState(() {

                        name = result['name'] ?? name;
                        bio = result['bio'] ?? bio;

                      });

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
                  profile: widget.profile,
                  posts: profilePosts,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}