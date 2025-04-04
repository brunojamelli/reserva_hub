import 'package:flutter/material.dart';
import 'package:reserva_hub/pages/home_screen.dart';
import 'package:reserva_hub/pages/login_page.dart';
import 'pages/espacos_page.dart';
import 'pages/reservas_screen.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(), // Tela com BottomNavigationBar
      debugShowCheckedModeBanner: false,
    );
  }
}