import 'package:dio/dio.dart';
import '../models/comunicado_model.dart';

// class ComunicadoRepository {
//   final Dio _dio = Dio(BaseOptions(baseUrl: 'http://192.168.1.66:3000'));

//   Future<List<Comunicado>> fetchComunicados() async {
//     try {
//       final response = await _dio.get('/comunicados');
//       return (response.data as List)
//           .map((json) => Comunicado.fromJson(json))
//           .toList();
//     } on DioException catch (e) {
//       throw Exception('Falha ao carregar comunicados: ${e.message}');
//     }
//   }
// }

class ComunicadoRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://192.168.1.66:3000'));

  Future<List<Comunicado>> fetchComunicados({int limit = 0}) async {
    try {
      final response = await _dio.get('/comunicados?_sort=data_envio&_order=desc');
      List<Comunicado> todosComunicados = (response.data as List)
          .map((json) => Comunicado.fromJson(json))
          .toList();
      
      return limit > 0 ? todosComunicados.take(limit).toList() : todosComunicados;
    } on DioException catch (e) {
      throw Exception('Falha ao carregar comunicados: ${e.message}');
    }
  }
}