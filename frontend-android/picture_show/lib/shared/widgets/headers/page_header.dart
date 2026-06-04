import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class PageHeader extends StatelessWidget{

  final String nome;

  const PageHeader({
    super.key,
    required this.nome
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
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

          child: Text(
            nome,
            style: TextStyle(
              fontFamily: 'JosefinSlab',
              fontSize: 32,
              color: Color(0xFF3C3535),
            ),
          ),
        ),
      ],
    );
  }
}