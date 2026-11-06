import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';
import 'view_state.dart';

class ApiProvider extends ChangeNotifier {
  final ApiService _service;
  List<ProductModel> _products = [];
  ViewState _state = ViewState.empty;
  String? _error;

  ApiProvider(this._service);

  List<ProductModel> get products => _products;
  ViewState get state => _state;
  String? get error => _error;

  Future<void> fetchProducts() async {
    _state = ViewState.loading;
    _error = null;
    notifyListeners();
    try {
      _products = await _service.getProducts();
      _state = _products.isEmpty ? ViewState.empty : ViewState.loaded;
    } catch (e) {
      _state = ViewState.error;
      _error = 'Gagal mengambil data API. Periksa koneksi internet.';
    }
    notifyListeners();
  }
}
