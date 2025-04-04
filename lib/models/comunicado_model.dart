class Comunicado {
  final String id;
  final String titulo;
  final String mensagem;
  final DateTime dataEnvio;
  final String prioridade;
  final String categoria;
  String? anexo;

  Comunicado({
    required this.id,
    required this.titulo,
    required this.mensagem,
    required this.dataEnvio,
    required this.prioridade,
    required this.categoria,
    this.anexo,
  });

  factory Comunicado.fromJson(Map<String, dynamic> json) {
    return Comunicado(
      id: json['id'].toString(),
      titulo: json['titulo'] as String,
      mensagem: json['mensagem'] as String,
      dataEnvio: DateTime.parse(json['data_envio'] as String),
      prioridade: json['prioridade'] as String,
      categoria: json['categoria'] as String,
      anexo: json['anexo'] != null ? json['anexo'] as String : null,
    );
  }
}