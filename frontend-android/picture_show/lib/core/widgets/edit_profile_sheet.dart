import 'package:flutter/material.dart';
import 'package:picture_show/features/perfil/entities/profile.dart';
import 'package:picture_show/shared/widgets/buttons/custom_button.dart';
import 'package:picture_show/shared/widgets/inputs/custom_input.dart';

class EditProfileSheet extends StatelessWidget {

  final Profile profile;

  const EditProfileSheet({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {

    final nameController = TextEditingController(
      text: profile.name,
    );

    final bioController = TextEditingController(
      text: profile.bio,
    );

    return Container(
      height: MediaQuery.of(context).size.height * 0.93,

      decoration: const BoxDecoration(
        color: Color(0xFFFFFEEF),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 5,
        ),
        child: Column(
          children: [

            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            const Text(
              'Editar Perfil',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'JosefinSlab', 
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Center(
              child: Stack(
                children: [

                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      profile.photoUrl,
                    ),
                  ),

                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFF3C3535),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 14,
                        color: Color(0xFFFFFEEF),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 16),

            CustomInput(
              label: 'Nome',
              hintText: 'Digite seu nome',
              controller: nameController,
            ),

            const SizedBox(height: 10),

            CustomInput(
              label: 'Bio',
              hintText: 'Conte um pouco sobre você',
              controller: bioController,
              maxLines: 4,
            ),

            const Spacer(),

            CustomButton(
              text: 'Salvar alterações',
              fontSize: 16,
              onPressed: () {
                Navigator.pop(context, {
                  'name': nameController.text,
                  'bio': bioController.text,
                });
              },
            ),

            const SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}