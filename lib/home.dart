import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> caminhadas = [];

  @override
  void initState() {
    super.initState();
    carregarCaminhadas();
  }

  Future<File> arquivo() async {
    final pasta = await getApplicationDocumentsDirectory();
    return File('${pasta.path}/caminhadas.json');
  }

  Future<void> carregarCaminhadas() async {
    final file = await arquivo();

    if (await file.exists()) {
      final texto = await file.readAsString();

      setState(() {
        caminhadas =
            List<Map<String, dynamic>>.from(jsonDecode(texto));
      });
    }
  }

  Future<void> salvarCaminhadas() async {
    final file = await arquivo();

    await file.writeAsString(
      jsonEncode(caminhadas),
    );
  }

  void abrirCadastro() {
    final partida = TextEditingController();
    final chegada = TextEditingController();
    final distancia = TextEditingController();
    final peso = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nova caminhada'),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                TextField(
                  controller: partida,
                  decoration: const InputDecoration(
                    labelText: 'Partida',
                  ),
                ),

                TextField(
                  controller: chegada,
                  decoration: const InputDecoration(
                    labelText: 'Chegada',
                  ),
                ),

                TextField(
                  controller: distancia,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Distância em km',
                  ),
                ),

                TextField(
                  controller: peso,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Peso atual em kg',
                  ),
                ),
              ],
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),

            ElevatedButton(
              onPressed: () async {
                if (partida.text.isEmpty ||
                    chegada.text.isEmpty ||
                    distancia.text.isEmpty ||
                    peso.text.isEmpty) {
                  return;
                }

                double distanciaValor =
                    double.parse(
                  distancia.text.replaceAll(',', '.'),
                );

                double pesoValor =
                    double.parse(
                  peso.text.replaceAll(',', '.'),
                );

                double calorias =
                    0.7 * pesoValor * distanciaValor;

                setState(() {
                  caminhadas.add({
                    'partida': partida.text,
                    'chegada': chegada.text,
                    'distancia_em_km': distanciaValor,
                    'peso_atual_kg': pesoValor,
                    'calorias': calorias,
                  });
                });

                await salvarCaminhadas();

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> excluirCaminhada(int index) async {
    setState(() {
      caminhadas.removeAt(index);
    });

    await salvarCaminhadas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back,
        ),

        title: const Text(
          'Caminhadas',
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: IconButton(
              onPressed: abrirCadastro,
              icon: const Icon(
                Icons.add,
                size: 32,
              ),
            ),
          ),
        ],
      ),

      body: caminhadas.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma caminhada cadastrada',
              ),
            )
          : ListView.builder(
              itemCount: caminhadas.length,

              itemBuilder: (context, index) {
                final caminhada =
                    caminhadas[index];

                return ListTile(
                  title: Text(
                    '${caminhada['partida']} → ${caminhada['chegada']}',
                  ),

                  subtitle: Text(
                    '${caminhada['distancia_em_km']} km   '
                    '${caminhada['peso_atual_kg']} kg   '
                    '${caminhada['calorias'].toStringAsFixed(1)} kcal',
                  ),

                  trailing: IconButton(
                    onPressed: () {
                      excluirCaminhada(index);
                    },

                    icon: const Icon(
                      Icons.close,
                      size: 32,
                    ),
                  ),
                );
              },
            ),
    );
  }
}