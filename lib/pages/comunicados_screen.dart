import 'package:flutter/material.dart';
import '../repositories/comunicado_repository.dart';
import '../models/comunicado_model.dart';

class ComunicadosScreen extends StatefulWidget {
  const ComunicadosScreen({super.key});

  @override
  State<ComunicadosScreen> createState() => _ComunicadosScreenState();
}

class _ComunicadosScreenState extends State<ComunicadosScreen> {
  final ComunicadoRepository _repository = ComunicadoRepository();
  late Future<List<Comunicado>> _futureComunicados = Future.value([]);
  bool _showAll = false;
  bool _hasMore = false;

  @override
  void initState() {
    super.initState();
    _loadComunicados();
  }

  void _loadComunicados() async {
    try {
      final allComunicados = await _repository.fetchComunicados();
      setState(() {
        _hasMore = allComunicados.length > 3;
        _futureComunicados = Future.value(
          _showAll ? allComunicados : allComunicados.take(3).toList()
        );
      });
    } catch (e) {
      setState(() {
        _futureComunicados = Future.error(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comunicados'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Comunicado>>(
              future: _futureComunicados,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhum comunicado disponível'));
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data!.length + (_hasMore && !_showAll ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == snapshot.data!.length && !_showAll) {
                        return _buildVerMaisButton();
                      }
                      final comunicado = snapshot.data![index];
                      return _buildComunicadoCard(comunicado);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComunicadoCard(Comunicado comunicado) {
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
        onTap: () {
          // Navegar para detalhes do comunicado
        },
      ),
    );
  }

  Widget _buildVerMaisButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          setState(() {
            _showAll = true;
          });
        },
        child: const Text(
          'Ver mais comunicados',
          style: TextStyle(fontSize: 16),
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