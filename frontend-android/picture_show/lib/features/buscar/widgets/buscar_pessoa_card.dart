import 'package:flutter/material.dart';

class BuscarPessoaCard extends StatelessWidget {
  const BuscarPessoaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundImage: NetworkImage(
            'https://tse2.mm.bing.net/th/id/OIP.8dwiRR3N734SXoHCE8LSRwAAAA?w=350&h=400&rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Text(
            'Nicolas Cage Again',

            style: const TextStyle(
              fontFamily: 'JosefinSlab',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3C3535),
            ),
          ),
        ),
      ],
    );
  }
}
