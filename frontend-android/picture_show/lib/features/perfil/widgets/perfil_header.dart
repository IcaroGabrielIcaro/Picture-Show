import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PerfilHeader extends StatelessWidget {
  const PerfilHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(16.0),

      child: Row(

        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              print("Botão de voltar pressionado");
            },
            icon: SvgPicture.asset(
              'lib/assets/icons/arrow_back.svg',
              width: 32,
              height: 32,
            ),
          ),

          const SizedBox(width: 10),

          Transform.translate(

            offset: const Offset(0, 3),

            child: const Text(
              'Nicolas Cage',
              style: TextStyle(
                fontFamily: 'JosefinSlab',
                fontSize: 32,
                color: Color(0xFF3C3535),
              ),
            ),
          )
          
        ],
      ),
    );
  }
}