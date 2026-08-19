import 'package:flutter/material.dart';
import 'home.dart';

class Splash extends StatelessWidget {
  final bool temaEscuro;
  final VoidCallback mudarTema;

  const Splash({
    super.key,
    required this.temaEscuro,
    required this.mudarTema,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.directions_walk,
                      size: 60,
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Tema escuro',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Switch(
                      value: temaEscuro,
                      onChanged: (_) {
                        mudarTema();
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: 140,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Home(),
                        ),
                      );
                    },
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 17,
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