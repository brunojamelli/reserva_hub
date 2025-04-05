import 'package:flutter/material.dart';
import 'package:reserva_hub/pages/reserva_detalhe_screen.dart';
import 'package:reserva_hub/repositories/reserva_repository.dart';
import '../models/reserva_model.dart';

class ReservasScreen extends StatefulWidget {
  const ReservasScreen({super.key});

  @override
  State<ReservasScreen> createState() => _ReservasScreenState();
}

class _ReservasScreenState extends State<ReservasScreen> {
  final ReservaRepository _reservaRepository = ReservaRepository();
  late Future<List<Reserva>> _futureReservas;

  @override
  void initState() {
    super.initState();
    _futureReservas = _reservaRepository.fetchReservas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Reservas'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Reserva>>(
        future: _futureReservas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final reservas = snapshot.data!;
          if (reservas.isEmpty) {
            return const Center(child: Text('Nenhuma reserva encontrada.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: reservas.length,
            itemBuilder: (context, index) {
              final r = reservas[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                child: ListTile(
                  title: Text(r.nomeEvento),
                  subtitle: Text('Data: ${r.data} | ${r.horaInicio} - ${r.horaFim}\nStatus: ${r.status}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReservaDetalheScreen(reserva: r),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
