import 'package:flutter/material.dart';
import '../models/comunicado_model.dart';

class ComunicadoCard extends StatelessWidget {
  final Comunicado comunicado;
  final VoidCallback? onTap;

  const ComunicadoCard({
    super.key,
    required this.comunicado,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: comunicado.lido ? Colors.white : Colors.blue[50],
      child: ListTile(
        leading: _getPriorityIcon(comunicado.prioridade),
        title: Text(
          comunicado.titulo,
          style: TextStyle(
            fontWeight: comunicado.lido ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(comunicado.mensagem),
            const SizedBox(height: 4),
            Text(
              'Enviado em: ${_formatDate(comunicado.dataEnvio)}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        trailing: comunicado.lido 
            ? null 
            : const Icon(Icons.circle, color: Colors.blue, size: 12),
        onTap: onTap,
      ),
    );
  }

  Icon _getPriorityIcon(String prioridade) {
    switch (prioridade.toLowerCase()) {
      case 'alta':
        return const Icon(Icons.warning_amber, color: Colors.red);
      case 'media':
        return const Icon(Icons.warning_amber, color: Colors.orange);
      default:
        return const Icon(Icons.info_outline, color: Colors.blue);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}