import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<AuthProvider>();
    final ok = await auth.login(_email.text, _password.text);
    if (!mounted) return;
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.error ?? 'Login gagal')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.account_balance_wallet, size: 72, color: Color(0xFF176B57)),
                const SizedBox(height: 12),
                Text('Kas Kecil', textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold)),
                const Text('Masuk untuk mengelola kas kecil', textAlign: TextAlign.center),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                  validator: (v) => v == null || !v.contains('@') ? 'Masukkan email yang valid' : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                  validator: (v) => v == null || v.length < 6 ? 'Password minimal 6 karakter' : null,
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: auth.isLoading ? null : _login,
                  child: auth.isLoading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Login'),
                ),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                  child: const Text('Belum punya akun? Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
