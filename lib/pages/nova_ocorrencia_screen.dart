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
  final List<String> _fotos = [];
  
  final _tiposOcorrencia = [
    'Hidráulico',
    'Elétrico',
    'Estrutural',
    'Limpeza',
    'Segurança',
    'Outros'
  ];

  final _ocorrencia = Ocorrencia(
    id: 1,
    idUsuario: 1, // Substituir pelo ID do usuário logado
    tipo: '',
    local: '',
    descricao: '',
    dataRegistro: DateTime.now(),
    status: 'pendente',
    fotos: [],
    comentarios: [],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Ocorrência'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Tipo de Ocorrência',
                  border: OutlineInputBorder(),
                ),
                items: _tiposOcorrencia
                    .map((tipo) => DropdownMenuItem(
                          value: tipo,
                          child: Text(tipo),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _ocorrencia.tipo = value!;
                  });
                },
                validator: (value) =>
                    value == null ? 'Selecione um tipo' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Local exato',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o local' : null,
                onSaved: (value) => _ocorrencia.local = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descrição detalhada',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty
                    ? 'Descreva a ocorrência'
                    : null,
                onSaved: (value) => _ocorrencia.descricao = value!,
              ),
              const SizedBox(height: 16),
              // Adicione aqui o upload de fotos se necessário
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Registrar Ocorrência'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _repository.createOcorrencia(_ocorrencia);
        Navigator.pop(context, true); // Retorna true indicando sucesso
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao registrar: $e')),
        );
      }
    }
  }
}