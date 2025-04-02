class Espaco {
  final int id;
  final String nome;
  final String tipo;
  final List<String> recursos;

  Espaco({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.recursos,
  });

  factory Espaco.fromJson(Map<String, dynamic> json) {
    return Espaco(
      id: json['id'],
      nome: json['nome'],
      tipo: json['tipo'],
      recursos: List<String>.from(json['recursos']),
    );
  }
}