import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<AuthProvider>();
    final ok = await auth.register(_email.text, _password.text);
    if (!mounted) return;
    if (ok) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.error ?? 'Register gagal')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Buat Akun')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                validator: (v) => v == null || !v.contains('@') ? 'Email tidak valid' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _password,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password minimal 6 karakter', border: OutlineInputBorder()),
                validator: (v) => v == null || v.length < 6 ? 'Minimal 6 karakter' : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: auth.isLoading ? null : _register,
                  child: auth.isLoading ? const CircularProgressIndicator() : const Text('Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
