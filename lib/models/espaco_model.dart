class Espaco {
  final String id;
  final String nome;
  final String tipo;
  final String? foto;
  final int capacidade;
  final List<String> recursos;
  final String regras;
  final List<String> diasIndisponiveis;
  final String horarioAbertura;
  final String horarioFechamento;

  Espaco({
    required this.id,
    required this.nome,
    required this.tipo,
    this.foto,
    required this.capacidade,
    required this.recursos,
    required this.regras,
    required this.diasIndisponiveis,
    required this.horarioAbertura,
    required this.horarioFechamento,
  });

  factory Espaco.fromJson(Map<String, dynamic> json) {
    return Espaco(
      id: json['id'].toString(),
      nome: json['nome'],
      tipo: json['tipo'],
      foto: json['foto'],
      capacidade: json['capacidade'],
      recursos: List<String>.from(json['recursos']),
      regras: json['regras'],
      diasIndisponiveis: List<String>.from(json['dias_indisponiveis']),
      horarioAbertura: json['horario_abertura'],
      horarioFechamento: json['horario_fechamento'],
    );
  }
}