import 'package:flutter/material.dart';
import '../models/espaco_model.dart';

class EspacoCard extends StatelessWidget {
  final Espaco espaco;

  const EspacoCard({required this.espaco});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(espaco.nome, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Tipo: ${espaco.tipo}', style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 8),
            Wrap(
              spacing: 4,
              children: espaco.recursos.map((recurso) => Chip(
                label: Text(recurso),
                backgroundColor: Colors.blue[50],
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}