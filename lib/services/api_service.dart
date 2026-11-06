import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  Future<List<ProductModel>> getProducts() async {
    final response = await _dio.get('/products');
    final data = response.data as Map<String, dynamic>;
    final products = data['products'] as List<dynamic>? ?? [];
    return products
        .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
