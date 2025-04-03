class Financeiro {
  final int id;
  final int idUsuario;
  final String mesReferencia;
  final double valor;
  final DateTime vencimento;
  final String status;
  final DateTime? dataPagamento;
  final String codigoBarras;
  final DetalhesFinanceiro detalhes;

  Financeiro({
    required this.id,
    required this.idUsuario,
    required this.mesReferencia,
    required this.valor,
    required this.vencimento,
    required this.status,
    this.dataPagamento,
    required this.codigoBarras,
    required this.detalhes,
  });

  factory Financeiro.fromJson(Map<String, dynamic> json) {
    return Financeiro(
      id: json['id'] as int,
      idUsuario: json['id_usuario'] as int,
      mesReferencia: json['mes_referencia'] as String,
      valor: (json['valor'] as num).toDouble(),
      vencimento: DateTime.parse(json['vencimento'] as String),
      status: json['status'] as String,
      dataPagamento: json['data_pagamento'] != null 
          ? DateTime.parse(json['data_pagamento'] as String) 
          : null,
      codigoBarras: json['codigo_barras'] as String,
      detalhes: DetalhesFinanceiro.fromJson(json['detalhes'] as Map<String, dynamic>),
    );
  }
}

class DetalhesFinanceiro {
  final double fundoReserva;
  final double limpeza;
  final double seguranca;

  DetalhesFinanceiro({
    required this.fundoReserva,
    required this.limpeza,
    required this.seguranca,
  });

  factory DetalhesFinanceiro.fromJson(Map<String, dynamic> json) {
    return DetalhesFinanceiro(
      fundoReserva: (json['fundo_reserva'] as num).toDouble(),
      limpeza: (json['limpeza'] as num).toDouble(),
      seguranca: (json['segurança'] as num).toDouble(),
    );
  }
}