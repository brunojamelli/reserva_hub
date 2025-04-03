import 'package:flutter/material.dart';
import 'package:reserva_hub/pages/comunicados_screen.dart';
import 'package:reserva_hub/pages/financeiro_screen.dart';
import 'package:reserva_hub/pages/ocorrencia_screen.dart';
import 'espacos_page.dart';
import 'reservas_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReservaHub'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, 
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            // Card para Espaços
            _buildMenuCard(
              context,
              icon: Icons.home,
              title: 'Espaços',
              color: Colors.black,
              destination: EspacosPage(),
            ),

            // Card para Espaços
            _buildMenuCard(
              context,
              icon: Icons.calendar_today,
              title: 'Reservas',
              color: Colors.blue,
              destination: ReservasScreen(),
            ),
            
            // Card para Comunicados
            _buildMenuCard(
              context,
              icon: Icons.notification_add,
              title: 'Comunicados',
              color: Colors.green,
              destination: const ComunicadosScreen(),
            ),
            
            // Card para Financeiro
            _buildMenuCard(
              context,
              icon: Icons.monetization_on,
              title: 'Financeiro',
              color: Colors.orange,
              destination: const FinanceiroScreen(),
            ),
            
            // Card para Ocorrências
            _buildMenuCard(
              context,
              icon: Icons.report_problem_outlined,
              title: 'Ocorrências',
              color: Colors.red,
              destination: const OcorrenciaScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required Widget destination,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}