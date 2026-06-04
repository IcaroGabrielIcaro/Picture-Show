import 'package:flutter/material.dart';

class ConfiguracaoItem extends StatelessWidget {
  final IconData icon;
  final String titulo;

  const ConfiguracaoItem({super.key, required this.icon, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),

      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD0D0D0)),

        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF3C3535)),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              titulo,

              style: const TextStyle(
                fontFamily: 'JosefinSlab',
                fontSize: 22,
                color: Color(0xFF3C3535),
              ),
            ),
          ),

          const Icon(Icons.chevron_right, color: Color(0xFF3C3535)),
        ],
      ),
    );
  }
}
