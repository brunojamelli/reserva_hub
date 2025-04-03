import 'package:flutter/material.dart';
import '../models/comunicado_model.dart';

class ComunicadoCard extends StatelessWidget {
  final Comunicado comunicado;
  final VoidCallback? onTap;
  final bool compact;

  const ComunicadoCard({
    super.key,
    required this.comunicado,
    this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: compact ? const EdgeInsets.all(8) : const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _getPriorityIcon(comunicado.prioridade),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      comunicado.titulo,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: compact ? 14 : 16,
                      ),
                    ),
                  ),
                  if (!comunicado.lido)
                    const Icon(Icons.circle, color: Colors.blue, size: 12),
                ],
              ),
              if (!compact) const SizedBox(height: 4),
              Text(
                comunicado.mensagem,
                maxLines: compact ? 1 : 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: compact ? 12 : 14),
              ),
              if (!compact) const SizedBox(height: 4),
              Text(
                'Enviado em: ${_formatDate(comunicado.dataEnvio)}',
                style: TextStyle(
                  fontSize: compact ? 10 : 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
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