import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service;
  StreamSubscription<User?>? _subscription;
  User? _user;
  bool _loading = false;
  String? _error;

  AuthProvider(this._service) {
    _subscription = _service.authStateChanges.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  User? get user => _user;
  bool get isLoading => _loading;
  String? get error => _error;

  Future<bool> login(String email, String password) =>
      _run(() => _service.login(email, password));

  Future<bool> register(String email, String password) =>
      _run(() => _service.register(email, password));

  Future<bool> _run(Future<dynamic> Function() action) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      await action();
      return true;
    } on FirebaseAuthException catch (e) {
      _error = e.message ?? 'Autentikasi gagal.';
      return false;
    } catch (e) {
      _error = 'Terjadi kesalahan: $e';
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() => _service.logout();

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
