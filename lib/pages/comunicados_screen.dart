import 'package:flutter/material.dart';
import '../repositories/comunicado_repository.dart';
import '../models/comunicado_model.dart';
import '../widgets/comunicado_card.dart';

class ComunicadosScreen extends StatefulWidget {
  const ComunicadosScreen({super.key});

  @override
  State<ComunicadosScreen> createState() => _ComunicadosScreenState();
}

class _ComunicadosScreenState extends State<ComunicadosScreen> {
  final ComunicadoRepository _repository = ComunicadoRepository();
  late Future<List<Comunicado>> _futureComunicados;

  @override
  void initState() {
    super.initState();
    _futureComunicados = _repository.fetchComunicados().then((comunicados) {
      return comunicados.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comunicados'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _futureComunicados = _repository.fetchComunicados();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Comunicado>>(
        future: _futureComunicados,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Erro ao carregar comunicados'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _futureComunicados = _repository.fetchComunicados();
                      });
                    },
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum comunicado disponível'));
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _futureComunicados = _repository.fetchComunicados();
                });
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final comunicado = snapshot.data![index];
                  return ComunicadoCard(
                    comunicado: comunicado,
                    onTap: () {
                      // Navegar para detalhes do comunicado
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}