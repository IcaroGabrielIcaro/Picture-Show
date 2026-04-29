import 'package:flutter/material.dart';

class PerfilPostsGrid extends StatelessWidget {
  const PerfilPostsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(2),
          color: Colors.grey,
        );
      },
    );
  }
}