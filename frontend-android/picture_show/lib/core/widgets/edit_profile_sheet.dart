import 'package:flutter/material.dart';
import 'package:picture_show/features/perfil/entities/profile.dart';

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

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nome',
                style: TextStyle(
                  fontFamily: 'JosefinSlab', 
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 4),

            TextFormField(
              controller: nameController,

              style: const TextStyle(
                fontSize: 14,
              ),

              decoration: InputDecoration(

                isDense: true,

                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(
                      255,
                      123,
                      123,
                      123,
                    ).withValues(alpha: 0.3),
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(
                      255,
                      123,
                      123,
                      123,
                    ).withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Bio',
                style: TextStyle(
                  fontFamily: 'JosefinSlab', 
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 4),

            TextFormField(
              controller: bioController,
              maxLines: 4,

              style: const TextStyle(
                fontSize: 14,
              ),

              decoration: InputDecoration(

                isDense: true,

                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(
                      255,
                      123,
                      123,
                      123,
                    ).withValues(alpha: 0.3),
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(
                      255,
                      123,
                      123,
                      123,
                    ).withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {

                  Navigator.pop(context, {
                    'name': nameController.text,
                    'bio': bioController.text,
                  });

                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3C3535),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                child: const Text(
                  'Salvar alterações',
                  style: TextStyle(
                    fontFamily: 'JosefinSlab', 
                    color: Color(0xFFFFFEEF),
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}