import 'package:flutter/material.dart';
import '../models/espaco_model.dart';

class EspacoDetalhesPage extends StatelessWidget {
  final Espaco espaco;

  const EspacoDetalhesPage({Key? key, required this.espaco}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(espaco.nome),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagem do espaço
            // _buildEspacoImage(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tipo e Capacidade
                  _buildTipoECapacidade(context),
                  const SizedBox(height: 16),
                  
                  // Horário de Funcionamento
                  _buildHorarioFuncionamento(context),
                  const SizedBox(height: 16),
                  
                  // Recursos
                  _buildSectionTitle('Recursos Disponíveis'),
                  _buildRecursosChips(),
                  const SizedBox(height: 16),
                  
                  // Regras
                  _buildSectionTitle('Regras do Espaço'),
                  Text(espaco.regras),
                  const SizedBox(height: 16),
                  
                  // Dias Indisponíveis
                  if (espaco.diasIndisponiveis.isNotEmpty) ...[
                    _buildSectionTitle('Dias Indisponíveis'),
                    Text(espaco.diasIndisponiveis.join(', ')),
                    const SizedBox(height: 16),
                  ],
                  
                  // Botão de Reserva
                  _buildReservaButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildEspacoImage() {
  //   return Container(
  //     height: 250,
  //     color: Colors.grey[200],
  //     child: espaco.foto != null
  //         ? Image.network(espaco.foto!, fit: BoxFit.cover)
  //         : Center(child: Icon(Icons.photo, size: 100, color: Colors.grey)),
  //   );
  // }

  Widget _buildTipoECapacidade(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Chip(
          label: Text(
            espaco.tipo.toUpperCase(),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        Text(
          'Capacidade: ${espaco.capacidade} pessoas',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildHorarioFuncionamento(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildHorarioItem(
            context,
            icon: Icons.access_time,
            label: 'Abertura',
            value: espaco.horarioAbertura,
          ),
          _buildHorarioItem(
            context,
            icon: Icons.access_time_filled,
            label: 'Fechamento',
            value: espaco.horarioFechamento,
          ),
        ],
      ),
    );
  }

  Widget _buildHorarioItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12)),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildRecursosChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: espaco.recursos
          .map((recurso) => Chip(
                label: Text(recurso),
                backgroundColor: Colors.blue[50],
              ))
          .toList(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildReservaButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          // TODO: Implementar navegação para tela de reserva
        },
        child: const Text(
          'RESERVAR AGORA',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}