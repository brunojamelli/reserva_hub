import 'package:flutter/material.dart';
import 'package:reserva_hub/models/usuario_model.dart';
import 'package:reserva_hub/pages/comunicados_screen.dart';
import 'package:reserva_hub/pages/financeiro_screen.dart';
import 'package:reserva_hub/pages/login_page.dart';
import 'package:reserva_hub/pages/ocorrencia_screen.dart';
import 'package:reserva_hub/services/user_storage_service.dart';
import 'package:reserva_hub/widgets/ultimos_comunicados.dart';
import 'espacos_page.dart';
import 'reservas_screen.dart';

class HomeScreen extends StatefulWidget  {
  const HomeScreen({super.key});

   @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  UsuarioModel? _usuario;

  @override
  void initState() {
    super.initState();
    _carregarUsuario();
  }
  
  Future<void> _carregarUsuario() async {
    final user = await UserStorageService().getUser();
    setState(() {
      _usuario = user;
    });
  }

  Future<void> _logout() async {
    await UserStorageService().logout();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logout realizado com sucesso')),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReservaHub'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: _logout,
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
             // Saudação
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _usuario != null
                    ? 'Olá, ${_usuario!.nome} 👋'
                    : 'Olá, visitante 👋',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Widget dos últimos comunicados
            const UltimosComunicados(),
            
            // Menu principal
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                    context,
                    icon: Icons.home,
                    title: 'Espaços',
                    color: Colors.black,
                    destination: EspacosPage(),
                  ),
                  _buildMenuCard(
                    context,
                    icon: Icons.calendar_today,
                    title: 'Reservas',
                    color: Colors.blue,
                    destination: ReservasScreen(),
                  ),
                  _buildMenuCard(
                    context,
                    icon: Icons.notification_add,
                    title: 'Comunicados',
                    color: Colors.green,
                    destination: const ComunicadosScreen(),
                  ),
                  _buildMenuCard(
                    context,
                    icon: Icons.monetization_on,
                    title: 'Financeiro',
                    color: Colors.orange,
                    destination: const FinanceiroScreen(),
                  ),
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