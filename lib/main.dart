import 'package:flutter/material.dart';
import 'pages/espacos_page.dart'; // Importe a página de espaços

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReservaHub',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Cor principal do app
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: EspacosPage(), // Define EspacosPage como tela inicial
      debugShowCheckedModeBanner: false, // Remove o banner "Debug"
    );
  }
}