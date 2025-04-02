import 'package:flutter/material.dart';

class ComunicadosScreen extends StatelessWidget {
  const ComunicadosScreen({super.key});

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
                Icon(Icons.notification_add, size: 50, color: Colors.blue),
                SizedBox(height: 10),
                Text(
                  'Comunicados',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // ListView separada
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Número temporário de itens
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.notifications),
                    title: Text('Comunicado ${index + 1}'),
                    subtitle: const Text('Descrição do comunicado...'),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      // Ação ao clicar no item
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}