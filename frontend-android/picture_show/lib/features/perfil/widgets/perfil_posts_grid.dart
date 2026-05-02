import 'package:flutter/material.dart';

class PerfilPostsGrid extends StatelessWidget {
  const PerfilPostsGrid({super.key});

  @override
  Widget build(BuildContext context) {

    final List<String> images = [
      'https://picsum.photos/300?1',
      'https://picsum.photos/300?2',
      'https://picsum.photos/300?3',
      'https://picsum.photos/300?4',
      'https://picsum.photos/300?5',
      'https://picsum.photos/300?6',
      'https://picsum.photos/300?7',
      'https://picsum.photos/300?8',
      'https://picsum.photos/300?9',
      'https://picsum.photos/300?10',
      'https://picsum.photos/300?11',
      'https://picsum.photos/300?12',
    ];

    return GridView.builder(

      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: images.length,

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 0.85,
      ),

      itemBuilder: (context, index) {

        return Opacity(

          opacity: 0.8,

          child: Image.network(
            images[index],
            fit: BoxFit.cover,
          ),

        );

      },
    );
  }
}
