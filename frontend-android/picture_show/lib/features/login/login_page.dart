import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picture_show/shared/widgets/inputs/custom_input.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFFFFEEF),

      body: SafeArea(

        child: Center(

          child: SingleChildScrollView(

            padding: const EdgeInsets.all(24),

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                const Text(

                  'Picture Show',

                  style: TextStyle(
                    fontFamily: 'OoohBaby',
                    fontSize: 58,
                    color: Color(0xFF3C3535),
                  ),

                ),

                const SizedBox(height: 48),

                CustomInput(
                  label: 'Email',
                  hintText: 'Digite seu email',
                ),

                const SizedBox(height: 16),

                CustomInput(
                  label: 'Senha',
                  hintText: 'Digite sua senha',
                  isPassword: true,
                ),

                const SizedBox(height: 24),

                SizedBox(

                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton(

                    onPressed: () {
                      context.goNamed('feed');
                    },

                    style: ElevatedButton.styleFrom(

                      backgroundColor: const Color(0xFF3C3535),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                    ),

                    child: const Text(

                      'Entrar',

                      style: TextStyle(
                        fontFamily: 'JosefinSlab',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFEEF),
                      ),

                    ),

                  ),

                ),

              ],

            ),

          ),

        ),

      ),

    );

  }

}