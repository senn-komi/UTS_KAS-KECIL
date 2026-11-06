import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/transaction_model.dart';
import '../services/firestore_service.dart';
import 'view_state.dart';

class TransactionProvider extends ChangeNotifier {
  final FirestoreService _service;

  StreamSubscription<List<TransactionModel>>? _subscription;

  List<TransactionModel> _transactions = [];

  ViewState _state = ViewState.empty;

  String? _error;

  // Menyimpan UID yang sedang didengarkan
  String? _listenedUid;

  TransactionProvider(this._service);

  List<TransactionModel> get transactions => _transactions;

  ViewState get state => _state;

  String? get error => _error;

  // Total pemasukan
  double get totalIncome => _transactions
      .where((t) => t.isIncome)
      .fold(0, (sum, t) => sum + t.amount);

  // Total pengeluaran
  double get totalExpense => _transactions
      .where((t) => !t.isIncome)
      .fold(0, (sum, t) => sum + t.amount);

  // Saldo akhir
  double get balance => totalIncome - totalExpense;

  // STREAM FIRESTORE
  void listenToTransactions(String uid) {
    // Hindari subscription berulang untuk UID yang sama
    if (_listenedUid == uid && _subscription != null) {
      return;
    }

    _listenedUid = uid;

    _subscription?.cancel();
    _subscription = null;

    _state = ViewState.loading;
    _error = null;
    notifyListeners();

    _subscription = _service
        .streamTransactions(uid)
        .listen(
          (items) {
            _transactions = items;

            _state = items.isEmpty ? ViewState.empty : ViewState.loaded;

            _error = null;
            notifyListeners();
          },
          onError: (Object e) {
            _subscription = null;

            _state = ViewState.error;
            _error = e.toString();

            notifyListeners();
          },
        );
  }

  // FUTURE: MENGAMBIL DATA SEKALI
  Future<void> loadOnce(String uid) async {
    _state = ViewState.loading;
    _error = null;
    notifyListeners();

    try {
      _transactions = await _service.getTransactions(uid);

      _state = _transactions.isEmpty ? ViewState.empty : ViewState.loaded;

      _error = null;
    } catch (e) {
      _state = ViewState.error;
      _error = e.toString();
    }

    notifyListeners();
  }

  // TAMBAH TRANSAKSI
  Future<void> add(TransactionModel item) async {
    await _perform(() => _service.addTransaction(item));
  }

  // EDIT TRANSAKSI
  Future<void> update(TransactionModel item) async {
    await _perform(() => _service.updateTransaction(item));
  }

  // HAPUS TRANSAKSI
  Future<void> delete(String id) async {
    await _perform(() => _service.deleteTransaction(id));
  }

  // PENANGANAN OPERASI CRUD
  Future<void> _perform(Future<void> Function() action) async {
    try {
      await action();
    } catch (e) {
      _error = e.toString();
      _state = ViewState.error;

      notifyListeners();

      rethrow;
    }
  }

  // DISPOSE STREAM
  @override
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _listenedUid = null;

    super.dispose();
  }
}
