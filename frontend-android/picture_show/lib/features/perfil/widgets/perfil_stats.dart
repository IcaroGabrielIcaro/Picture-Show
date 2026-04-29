import 'package:flutter/material.dart';

class PerfilStats extends StatelessWidget {
  const PerfilStats({super.key});

  Widget buildItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildItem('Fotos', '3'),
        buildItem('Seguidores', '7'),
        buildItem('Seguindo', '9'),
      ],
    );
  }
}