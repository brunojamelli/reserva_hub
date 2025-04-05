import 'package:flutter/material.dart';
import '../models/reserva_model.dart';

class ReservaDetalheScreen extends StatelessWidget {
  final Reserva reserva;

  const ReservaDetalheScreen({super.key, required this.reserva});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Reserva'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSectionCard(
              context,
              title: 'Informações do Evento',
              children: [
                _buildDetailTile(Icons.event, 'Nome do Evento', reserva.nomeEvento),
                _buildDetailTile(Icons.date_range, 'Data', reserva.data),
                _buildDetailTile(Icons.access_time, 'Horário', '${reserva.horaInicio} - ${reserva.horaFim}'),
              ],
            ),
            const SizedBox(height: 12),
            _buildSectionCard(
              context,
              title: 'Contato',
              children: [
                _buildDetailTile(Icons.phone, 'Telefone', reserva.telefoneContato),
                _buildDetailTile(Icons.groups, 'Convidados', reserva.convidados.join(', ')),
              ],
            ),
            const SizedBox(height: 12),
            _buildSectionCard(
              context,
              title: 'Detalhes Técnicos',
              children: [
                _buildDetailTile(Icons.apartment, 'Espaço', 'Espaço ID: ${reserva.idEspaco}'),
                _buildDetailTile(Icons.person, 'Usuário ID', reserva.idUsuario),
                _buildDetailTile(Icons.calendar_today, 'Data da Reserva', reserva.dataReserva.split('T').first),
              ],
            ),
            const SizedBox(height: 12),
            _buildStatusBadge(reserva.status),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile(IconData icon, String title, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
    );
  }

  Widget _buildSectionCard(BuildContext context,
      {required String title, required List<Widget> children}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    )),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final color = _statusColor(status);
    return Chip(
      label: Text(
        'Status: ${status[0].toUpperCase()}${status.substring(1)}',
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmada':
        return Colors.green;
      case 'pendente':
        return Colors.orange;
      case 'cancelada':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
