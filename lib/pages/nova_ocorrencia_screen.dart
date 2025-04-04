import 'package:flutter/material.dart';
import '../models/ocorrencia_model.dart';
import '../repositories/ocorrencia_repository.dart';

class NovaOcorrenciaScreen extends StatefulWidget {
  const NovaOcorrenciaScreen({super.key});

  @override
  State<NovaOcorrenciaScreen> createState() => _NovaOcorrenciaScreenState();
}

class _NovaOcorrenciaScreenState extends State<NovaOcorrenciaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _repository = OcorrenciaRepository();

  String? _tipo;
  String? _local;
  String? _descricao;

  bool _isSaving = false;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    final novaOcorrencia = Ocorrencia(
      id: '',
      idUsuario: 1, // ou obtenha do login
      tipo: _tipo!,
      local: _local!,
      descricao: _descricao!,
      dataRegistro: DateTime.now(),
      status: 'pendente',
      fotos: [], // você pode implementar seleção de imagem depois
      comentarios: [],
    );

    setState(() => _isSaving = true);

    try {
      await _repository.createOcorrencia(novaOcorrencia);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ocorrência registrada com sucesso!')),
      );
      Navigator.pop(context);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar ocorrência: $e')),
      );
    } finally {
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nova Ocorrência')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Tipo'),
                items: ['segurança', 'limpeza', 'eletrico','hidráulico', 'outros']
                    .map((tipo) => DropdownMenuItem(
                          value: tipo,
                          child: Text(tipo),
                        ))
                    .toList(),
                onChanged: (val) => _tipo = val,
                validator: (val) => val == null ? 'Selecione um tipo' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Local'),
                onSaved: (val) => _local = val,
                validator: (val) => val!.isEmpty ? 'Informe o local' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                maxLines: 4,
                onSaved: (val) => _descricao = val,
                validator: (val) => val!.isEmpty ? 'Descreva a ocorrência' : null,
              ),
              const SizedBox(height: 20),
              _isSaving
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Registrar Ocorrência'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
