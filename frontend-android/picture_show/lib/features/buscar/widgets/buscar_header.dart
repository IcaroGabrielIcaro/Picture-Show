import 'package:flutter/material.dart';

class BuscarHeader extends StatefulWidget {

  const BuscarHeader({super.key});

  @override
  State<BuscarHeader> createState() => _BuscarHeaderState();
}

class _BuscarHeaderState extends State<BuscarHeader> {

  final TextEditingController controller = TextEditingController();

  String searchText = '';

  void clearSearch() {

    controller.clear();

    setState(() {
      searchText = '';
    });

  }

  void handleSearch() {

    if (searchText.trim().length < 3) {

      showDialog(
        context: context,

        builder: (context) {

          return AlertDialog(

            title: const Text('Busca inválida'),

            content: const Text(
              'Digite pelo menos 3 caracteres.',
            ),

            actions: [

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child: const Text('OK'),
              ),

            ],
          );
        },
      );

      return;
    }

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text('Busca'),

          content: Text(
            'Ainda não existe conexão com o backend.\n\nBusca digitada:\n$searchText',
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Fechar'),
            ),

          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(

      decoration: BoxDecoration(

        border: Border.all(
          color: const Color(0xFF3C3535),
          width: 1,
        ),

        borderRadius: BorderRadius.circular(12),
      ),

      child: Row(
        children: [

          IconButton(

            onPressed: handleSearch,

            padding: EdgeInsets.zero,

            constraints: const BoxConstraints(),

            splashRadius: 20,

            icon: const Icon(
              Icons.search,
              color: Color(0xFF3C3535),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: TextField(

              controller: controller,

              onChanged: (value) {

                print(value);

                setState(() {
                  searchText = value;
                });

              },

              onSubmitted: (_) {
                handleSearch();
              },

              decoration: const InputDecoration(
                hintText: 'Buscar por nome',
                border: InputBorder.none,

                hintStyle: TextStyle(
                  fontFamily: 'JosefinSlab',
                  fontSize: 18,
                  color: Color(0xFF3C3535),
                ),
              ),

              style: const TextStyle(
                fontFamily: 'JosefinSlab',
                fontSize: 18,
                color: Color(0xFF3C3535),
              ),
            ),
          ),

          if (searchText.isNotEmpty)

            IconButton(

              onPressed: clearSearch,

              padding: EdgeInsets.zero,

              constraints: const BoxConstraints(),

              splashRadius: 20,

              icon: const Icon(
                Icons.close,
                size: 20,
                color: Color(0xFF3C3535),
              ),
            ),

        ],
      ),
    );
  }
}