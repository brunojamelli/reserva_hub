class Reserva {
  final String idEspaco;
  final String idUsuario;
  final String data;
  final String horaInicio;
  final String horaFim;
  final String nomeEvento;
  final List<String> convidados;
  final String telefoneContato;
  final String status;
  final String dataReserva;

  Reserva({
    required this.idEspaco,
    required this.idUsuario,
    required this.data,
    required this.horaInicio,
    required this.horaFim,
    required this.nomeEvento,
    required this.convidados,
    required this.telefoneContato,
    required this.status,
    required this.dataReserva,
  });

  Map<String, dynamic> toJson() => {
        'id_espaco': idEspaco,
        'id_usuario': idUsuario,
        'data': data,
        'hora_inicio': horaInicio,
        'hora_fim': horaFim,
        'nome_evento': nomeEvento,
        'convidados': convidados,
        'telefone_contato': telefoneContato,
        'status': status,
        'data_reserva': dataReserva,
      };
}
