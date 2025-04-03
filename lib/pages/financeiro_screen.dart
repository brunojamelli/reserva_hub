import 'package:flutter/material.dart';
import '../repositories/financeiro_repository.dart';
import '../models/financeiro_model.dart';

class FinanceiroScreen extends StatefulWidget {
  const FinanceiroScreen({super.key});

  @override
  State<FinanceiroScreen> createState() => _FinanceiroScreenState();
}

class _FinanceiroScreenState extends State<FinanceiroScreen> {
  final FinanceiroRepository _repository = FinanceiroRepository();
  late Future<List<Financeiro>> _futureFinanceiro;
  bool _showDetails = false;

  @override
  void initState() {
    super.initState();
    _futureFinanceiro = _repository.fetchFinanceiro();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financeiro'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Financeiro>>(
        future: _futureFinanceiro,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum registro financeiro encontrado'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final financeiro = snapshot.data![index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              financeiro.mesReferencia,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Chip(
                              label: Text(
                                financeiro.status.toUpperCase(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: financeiro.status == 'pago'
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Valor: R\$${financeiro.valor.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Vencimento: ${_formatDate(financeiro.vencimento)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        if (financeiro.status == 'pago')
                          Text(
                            'Pago em: ${_formatDate(financeiro.dataPagamento!)}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        const SizedBox(height: 8),
                        ExpansionTile(
                          title: const Text('Detalhes do Rateio'),
                          initiallyExpanded: _showDetails,
                          onExpansionChanged: (expanded) {
                            setState(() {
                              _showDetails = expanded;
                            });
                          },
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  _buildDetailRow('Fundo Reserva', financeiro.detalhes.fundoReserva),
                                  _buildDetailRow('Limpeza', financeiro.detalhes.limpeza),
                                  _buildDetailRow('Segurança', financeiro.detalhes.seguranca),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Código de Barras: ${financeiro.codigoBarras}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Monospace',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ação para pagar/gerar boleto
        },
        child: const Icon(Icons.payment),
      ),
    );
  }

  Widget _buildDetailRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text('R\$${value.toStringAsFixed(2)}'),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}