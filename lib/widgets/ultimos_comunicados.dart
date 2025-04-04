import 'package:flutter/material.dart';
import '../repositories/comunicado_repository.dart';
import '../models/comunicado_model.dart';
import '../widgets/comunicado_card.dart';
import '../pages/comunicados_screen.dart';

class UltimosComunicados extends StatelessWidget {
  const UltimosComunicados({super.key});

  @override
  Widget build(BuildContext context) {
    final ComunicadoRepository _repository = ComunicadoRepository();
    final Future<List<Comunicado>> _futureComunicados = 
        _repository.fetchComunicados(limit: 3);

    return FutureBuilder<List<Comunicado>>(
      future: _futureComunicados,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink(); // Ou um loading pequeno
        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink(); // Não mostra se não houver dados
        } else {
          final comunicadosOrdenados = snapshot.data!
            ..sort((a, b) => b.dataEnvio.compareTo(a.dataEnvio));
          
          final top2 = comunicadosOrdenados.take(2).toList();
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
              ...top2.map((comunicado) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ComunicadoCard(
                  comunicado: comunicado,
                  compact: true, // Adicione esta propriedade ao seu ComunicadoCard
                ),
              )).toList(),
            ],
          );
        }
      },
    );
  }
}