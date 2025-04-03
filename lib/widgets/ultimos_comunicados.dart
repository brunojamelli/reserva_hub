import 'package:flutter/material.dart';
import 'package:reserva_hub/pages/comunicados_screen.dart';
import '../repositories/comunicado_repository.dart';
import '../models/comunicado_model.dart';
import '../widgets/comunicado_card.dart';

class UltimosComunicados extends StatelessWidget {
  const UltimosComunicados({super.key});

  @override
  Widget build(BuildContext context) {
    final ComunicadoRepository _repository = ComunicadoRepository();
    final Future<List<Comunicado>> _futureComunicados = 
        _repository.fetchComunicados(limit: 2);

    return FutureBuilder<List<Comunicado>>(
      future: _futureComunicados,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const SizedBox.shrink(); // Não mostra erro na home
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink(); // Não mostra se não houver comunicados
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Últimos Comunicados',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...snapshot.data!.map((comunicado) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ComunicadoCard(
                  comunicado: comunicado,
                  onTap: () {
                    // Navegar para detalhes se necessário
                  },
                ),
              )).toList(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ComunicadosScreen(),
                        ),
                      );
                    },
                    child: const Text('Ver todos'),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}