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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildInfoTile('Evento', reserva.nomeEvento),
            _buildInfoTile('Data', reserva.data),
            _buildInfoTile('Horário', '${reserva.horaInicio} - ${reserva.horaFim}'),
            _buildInfoTile('Status', reserva.status),
            _buildInfoTile('Telefone de Contato', reserva.telefoneContato),
            _buildInfoTile('Data da Solicitação', reserva.dataReserva.split('T').first),
            _buildInfoTile('Espaço', reserva.idEspaco),
            _buildInfoTile('Convidados', reserva.convidados.join(', ')),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
        leading: const Icon(Icons.info_outline),
      ),
    );
  }
}
