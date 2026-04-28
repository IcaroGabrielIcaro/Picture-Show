import 'package:flutter/material.dart'

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://hips.hearstapps.com/hmg-prod/images/gettyimages-1046482274-square.jpg?resize=1200:*'
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Nicolas Cage',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              'nicolascage@email.com',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                print('Botão clicado');
              },
              child: const Text('Editar Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}