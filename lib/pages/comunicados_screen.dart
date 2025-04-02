import 'package:flutter/material.dart';

class ComunicadosScreen extends StatelessWidget {
  const ComunicadosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comunicados Mais Recentes'),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today, size: 50, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              'Tela de Comunicados',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Conteúdo será implementado aqui',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}