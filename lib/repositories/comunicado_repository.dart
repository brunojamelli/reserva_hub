import 'package:dio/dio.dart';
import '../models/comunicado_model.dart';

class ComunicadoRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://192.168.1.66:3000'));

  Future<List<Comunicado>> fetchComunicados() async {
    try {
      final response = await _dio.get('/comunicados');
      return (response.data as List)
          .map((json) => Comunicado.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception('Falha ao carregar comunicados: ${e.message}');
    }
  }
}