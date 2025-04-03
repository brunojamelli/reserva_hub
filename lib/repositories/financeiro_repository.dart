import 'package:dio/dio.dart';
import '../models/financeiro_model.dart';

class FinanceiroRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://192.168.1.66:3000'));

  Future<List<Financeiro>> fetchFinanceiro() async {
    try {
      final response = await _dio.get('/taxas');
      return (response.data as List)
          .map((json) => Financeiro.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception('Falha ao carregar dados financeiros: ${e.message}');
    }
  }
}