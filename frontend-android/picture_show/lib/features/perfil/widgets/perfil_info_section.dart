import 'package:flutter/material.dart';
import 'perfil_stats.dart';

class PerfilInfoSection extends StatelessWidget{
  const PerfilInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
            'https://hips.hearstapps.com/hmg-prod/images/gettyimages-1046482274-square.jpg?resize=1200:*',
          ),
        ),

        SizedBox(height: 10),

        Text(
          'Nicolas Cage',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        Text('Ator muito massa que faz filmes surtados porque sim. Me dê motivos para ele não ter feito.'),

        SizedBox(height: 10),

        PerfilStats(),

        SizedBox(height: 10),

        ElevatedButton(
          onPressed: null,
          child: Text('Editar Perfil'),
        ),
      ],
    );
  }
}