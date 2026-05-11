import 'package:flutter/material.dart';
import 'package:picture_show/features/buscar/widgets/buscar_header.dart';
import 'package:picture_show/features/buscar/widgets/buscar_pessoa_card.dart';

class BuscarPage extends StatelessWidget {
  const BuscarPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEEF),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuscarHeader(),

            SizedBox(height: 12),

            Divider(
              color: Color(0xFF3C3535),
              thickness: 1,
            ),

            SizedBox(height: 12),

            BuscarPessoaCard(),
            
            SizedBox(height: 12),

            BuscarPessoaCard(),
          ],
        ),
      ),
    );

  }
}