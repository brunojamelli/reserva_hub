import 'package:flutter/material.dart';

class OcorrenciaScreen extends StatelessWidget {
  const OcorrenciaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserva Hub'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Cabeçalho centralizado
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.report_problem_outlined, size: 50, color: Colors.red),
                SizedBox(height: 10),
                Text(
                  'Financeiro',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}