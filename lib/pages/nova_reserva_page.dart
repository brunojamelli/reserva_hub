import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reserva_hub/models/espaco_model.dart';
import 'package:reserva_hub/models/reserva_model.dart';
import 'package:reserva_hub/repositories/reserva_repository.dart';

class NovaReservaPage extends StatefulWidget {
  final Espaco espaco;
  const NovaReservaPage({Key? key, required this.espaco}) : super(key: key);

  @override
  State<NovaReservaPage> createState() => _ReservaPageState();
}

class _ReservaPageState extends State<NovaReservaPage> {
  final _nomeEventoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _convidadoController = TextEditingController();

  DateTime? _dataReserva;
  TimeOfDay? _horaInicio;
  TimeOfDay? _horaFim;

  final List<String> _convidados = [];

  void _adicionarConvidado() {
    final nome = _convidadoController.text.trim();
    if (nome.isNotEmpty) {
      setState(() {
        _convidados.add(nome);
        _convidadoController.clear();
      });
    }
  }

  Future<void> _selecionarData() async {
    final hoje = DateTime.now();
    final data = await showDatePicker(
      context: context,
      initialDate: hoje,
      firstDate: hoje,
      lastDate: DateTime(2100),
    );
    if (data != null) {
      setState(() => _dataReserva = data);
    }
  }

  Future<void> _selecionarHoraInicio() async {
    final hora = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (hora != null) {
      setState(() => _horaInicio = hora);
    }
  }

  Future<void> _selecionarHoraFim() async {
    final hora = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (hora != null) {
      setState(() => _horaFim = hora);
    }
  }

  Future<void> _salvarReserva() async {
    if (_dataReserva == null || _horaInicio == null || _horaFim == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios')),
      );
      return;
    }

    final reserva = Reserva(
      idEspaco: '1',
      idUsuario: '1',
      data: DateFormat('yyyy-MM-dd').format(_dataReserva!),
      horaInicio: _horaInicio!.format(context),
      horaFim: _horaFim!.format(context),
      nomeEvento: _nomeEventoController.text,
      convidados: _convidados,
      telefoneContato: _telefoneController.text,
      status: 'confirmada',
      dataReserva: DateTime.now().toUtc().toIso8601String(),
    );

    try {
      final repo = ReservaRepository();
      await repo.reservar(reserva);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reserva salva com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataFormatada = _dataReserva != null ? DateFormat('dd/MM/yyyy').format(_dataReserva!) : 'Selecionar data';

    return Scaffold(
      appBar: AppBar(title: const Text('Nova Reserva')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _nomeEventoController,
              decoration: const InputDecoration(labelText: 'Nome do Evento'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _telefoneController,
              decoration: const InputDecoration(labelText: 'Telefone de Contato'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _selecionarData,
              child: Text('Data: $dataFormatada'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _selecionarHoraInicio,
              child: Text('Hora Início: ${_horaInicio?.format(context) ?? "Selecionar"}'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _selecionarHoraFim,
              child: Text('Hora Fim: ${_horaFim?.format(context) ?? "Selecionar"}'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _convidadoController,
              decoration: InputDecoration(
                labelText: 'Adicionar Convidado',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _adicionarConvidado,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _convidados
                  .map((c) => Chip(
                        label: Text(c),
                        onDeleted: () => setState(() => _convidados.remove(c)),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _salvarReserva,
              child: const Text('Salvar Reserva'),
            ),
          ],
        ),
      ),
    );
  }
}
