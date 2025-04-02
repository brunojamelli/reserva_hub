import 'package:flutter/material.dart';
import '../repositories/espaco_repository.dart';
import '../models/espaco_model.dart';
import '../widgets/espaco_card.dart'; // Opcional

class EspacosPage extends StatefulWidget {
  @override
  _EspacosPageState createState() => _EspacosPageState();
}

class _EspacosPageState extends State<EspacosPage> {
  final EspacoRepository _repository = EspacoRepository();
  late Future<List<Espaco>> _futureEspacos;

  @override
  void initState() {
    super.initState();
    _futureEspacos = _repository.fetchEspacos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Espaços Disponíveis')),
      body: FutureBuilder<List<Espaco>>(
        future: _futureEspacos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final espaco = snapshot.data![index];
                return EspacoCard(espaco: espaco); // Ou ListTile direto
              },
            );
          }
        },
      ),
    );
  }
}