import 'package:flutter/material.dart';
import 'package:reserva_hub/pages/comunicados_screen.dart';
import 'espacos_page.dart';
import 'reservas_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Telas correspondentes a cada aba
  final List<Widget> _screens = [
    EspacosPage(),
    const ReservasScreen(),
    const ComunicadosScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Exibe a tela atual
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Espaços',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Reservas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add),
            label: 'Comunicados',
          ),
        ],
      ),
    );
  }
}