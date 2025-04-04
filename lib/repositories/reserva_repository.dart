import 'package:dio/dio.dart';
import 'package:reserva_hub/models/reserva_model.dart';

class ReservaRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://192.168.1.66:3000'));

  Future<void> reservar(Reserva reserva) async {
    try {
      // 1. Atualiza o espaço com o novo dia indisponível
      final espacoResponse = await _dio.get('/espacos/${reserva.idEspaco}');
      final espacoData = espacoResponse.data;
      final diasIndisponiveis = List<String>.from(espacoData['dias_indisponiveis'] ?? []);
      
      if (!diasIndisponiveis.contains(reserva.data)) {
        diasIndisponiveis.add(reserva.data);
      }

      await _dio.put(
        '/espacos/${reserva.idEspaco}',
        data: {
          ...espacoData,
          'dias_indisponiveis': diasIndisponiveis,
        },
      );

      // 2. Cria a reserva
      await _dio.post('/reserva', data: reserva.toJson());
    } catch (e) {
      print('Erro ao realizar reserva: $e');
      rethrow;
    }
  }
}
