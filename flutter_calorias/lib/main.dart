import 'package:flutter/material.dart';
import 'splash.dart';

void main() {
  runApp(const CaminhadasApp());
}

class CaminhadasApp extends StatefulWidget {
  const CaminhadasApp({super.key});

  @override
  State<CaminhadasApp> createState() => _CaminhadasAppState();
}

class _CaminhadasAppState extends State<CaminhadasApp> {
  ThemeMode tema = ThemeMode.light;

  void mudarTema() {
    setState(() {
      if (tema == ThemeMode.light) {
        tema = ThemeMode.dark;
      } else {
        tema = ThemeMode.light;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caminhadas',
      themeMode: tema,

      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),

      home: Splash(
        temaEscuro: tema == ThemeMode.dark,
        mudarTema: mudarTema,
      ),
    );
  }
}