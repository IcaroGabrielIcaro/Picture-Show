import 'package:flutter/material.dart';

class PerfilStats extends StatelessWidget {
  final bool isLargeScreen;

  const PerfilStats({
    super.key,
    required this.isLargeScreen,
  });

  Widget buildItem(String label, String value) {
    return Row(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'JosefinSlab',
            fontSize: isLargeScreen ? 24 : 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3C3535),
          )
        ),

        SizedBox(width: isLargeScreen ? 12 : 6),

        Text(
          label,
          style: TextStyle(
            fontFamily: 'JosefinSlab',
            fontSize: isLargeScreen ? 20 : 18,
            color: Color(0xFF3C3535),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(

      mainAxisSize: MainAxisSize.min,

      children: [
        buildItem('Fotos', '3'),
        SizedBox(width: isLargeScreen ? 24 : 12),
        buildItem('Seguidores', '7'),
        SizedBox(width: isLargeScreen ? 24 : 12),
        buildItem('Seguindo', '9'),
      ],
    );
  }
}