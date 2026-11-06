import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction_model.dart';
import '../providers/auth_provider.dart';
import '../providers/transaction_provider.dart';

class TransactionForm extends StatefulWidget {
  final TransactionModel? transaction;
  const TransactionForm({super.key, this.transaction});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _amount;
  late final TextEditingController _description;
  late String _type;

  @override
  void initState() {
    super.initState();
    final item = widget.transaction;
    _title = TextEditingController(text: item?.title ?? '');
    _amount = TextEditingController(text: item?.amount.toString() ?? '');
    _description = TextEditingController(text: item?.description ?? '');
    _type = item?.type ?? 'expense';
  }

  @override
  void dispose() {
    _title.dispose();
    _amount.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final user = context.read<AuthProvider>().user;
    if (user == null) return;
    final old = widget.transaction;
    final model = TransactionModel(
      id: old?.id ?? '',
      title: _title.text.trim(),
      amount: double.parse(_amount.text.replaceAll(',', '.')),
      type: _type,
      description: _description.text.trim(),
      createdAt: old?.createdAt ?? DateTime.now(),
      owner: user.uid,
    );
    try {
      final provider = context.read<TransactionProvider>();
      if (old == null) {
        await provider.add(model);
      } else {
        await provider.update(model);
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan transaksi: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20, right: 20, top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(widget.transaction == null ? 'Tambah Transaksi' : 'Edit Transaksi',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Nama transaksi', border: OutlineInputBorder()),
                validator: (v) => v == null || v.trim().isEmpty ? 'Nama wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amount,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Nominal (contoh: 150000)', border: OutlineInputBorder()),
                validator: (v) {
                  final amount = double.tryParse((v ?? '').replaceAll(',', '.'));
                  return amount == null || amount <= 0 ? 'Nominal harus lebih dari 0' : null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _type,
                decoration: const InputDecoration(labelText: 'Jenis transaksi', border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'income', child: Text('Pemasukan')),
                  DropdownMenuItem(value: 'expense', child: Text('Pengeluaran')),
                ],
                onChanged: (value) => setState(() => _type = value ?? 'expense'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _description,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Keterangan', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 18),
              FilledButton(onPressed: _save, child: const Text('Simpan')),
            ],
          ),
        ),
      ),
    );
  }
}
