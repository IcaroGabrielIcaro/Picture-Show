import 'package:flutter/material.dart';
import 'perfil_stats.dart';

class PerfilInfoSection extends StatelessWidget {
  const PerfilInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth > 600;

        final double avatarRadius = isLargeScreen ? 104 : 52;
        final double titleSize = isLargeScreen ? 32 : 26;
        final double descriptionSize = isLargeScreen ? 24 : 18;
        final double buttonTextSize = isLargeScreen ? 24 : 20;

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
                    backgroundImage: const NetworkImage(
                      'https://hips.hearstapps.com/hmg-prod/images/gettyimages-1046482274-square.jpg?resize=1200:*',
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        'Nicolas Cage',

                        style: TextStyle(
                          fontFamily: 'JosefinSlab', 
                          fontSize: titleSize, 
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3C3535),
                        ),

                      ),

                      Text(
                        'Ator muito massa que faz filmes surtados porque sim. Me dê motivos para ele não ter feito.',

                        style: TextStyle(
                          fontFamily: 'JosefinSlab',
                          fontSize: descriptionSize,
                          color: Color(0xFF3C3535),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            PerfilStats(isLargeScreen: isLargeScreen),

            const SizedBox(height: 12),

            SizedBox(

              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},

                style: ElevatedButton.styleFrom(

                  backgroundColor: const Color(0xFF3C3535),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                ),

                child: Text(
                  'Seguir',

                  style: TextStyle(
                    fontFamily: 'JosefinSlab',
                    fontSize: buttonTextSize,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFEEF),
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