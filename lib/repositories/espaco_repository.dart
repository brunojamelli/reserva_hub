import 'package:dio/dio.dart';
import '../models/espaco_model.dart';

class EspacoRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://192.168.1.66:3000'));

  Future<List<Espaco>> fetchEspacos() async {
    try {
      final response = await _dio.get('/espacos');
      return (response.data as List)
          .map((json) => Espaco.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception('Falha ao carregar espaços: ${e.message}');
    }
  }
}