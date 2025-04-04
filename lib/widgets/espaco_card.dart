import 'package:flutter/material.dart';
import 'package:reserva_hub/pages/espaco_detalhes_page.dart';
import '../models/espaco_model.dart';


class EspacoCard extends StatelessWidget {
  final Espaco espaco;

  const EspacoCard({Key? key, required this.espaco}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EspacoDetalhesPage(espaco: espaco),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                espaco.nome,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              // Removido o bloco de localização
              Text(
                'Capacidade: ${espaco.capacidade} pessoas',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              SizedBox(height: 4),
              Text(
                'Tipo: ${espaco.tipo}',
                style: TextStyle(color: Colors.grey.shade600),
              ),
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
      ),
    );
  }
}