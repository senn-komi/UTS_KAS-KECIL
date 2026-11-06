import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/transaction_model.dart';
import '../providers/auth_provider.dart';
import '../providers/transaction_provider.dart';
import '../providers/view_state.dart';
import '../widgets/transaction_form.dart';
import '../widgets/transaction_card.dart';
import 'api_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _listenedUid;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final uid = context.read<AuthProvider>().user?.uid;

    if (uid != null && uid != _listenedUid) {
      _listenedUid = uid;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        context.read<TransactionProvider>().listenToTransactions(uid);
      });
    }
  }

  String rupiah(double value) =>
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(value);

  Future<void> _openForm({TransactionModel? item}) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => TransactionForm(transaction: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kas Kecil', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            tooltip: 'Referensi produk API',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ApiScreen())),
            icon: const Icon(Icons.storefront_outlined),
          ),
          IconButton(
            tooltip: 'Logout',
            onPressed: () => auth.logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add),
        label: const Text('Transaksi'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final uid = auth.user?.uid;
          if (uid != null) await provider.loadOnce(uid);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF176B57),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Saldo Kas Saat Ini', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 8),
                  Text(rupiah(provider.balance),
                    style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: _summary('Pemasukan', provider.totalIncome, rupiah, Icons.arrow_downward)),
                      Expanded(child: _summary('Pengeluaran', provider.totalExpense, rupiah, Icons.arrow_upward)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Riwayat Transaksi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            if (provider.state == ViewState.loading)
              const Padding(padding: EdgeInsets.all(32), child: Center(child: CircularProgressIndicator()))
            else if (provider.state == ViewState.error)
              _message(provider.error ?? 'Terjadi kesalahan', () {
                final uid = auth.user?.uid;
                if (uid != null) provider.listenToTransactions(uid);
              })
            else if (provider.state == ViewState.empty)
              const Padding(
                padding: EdgeInsets.all(28),
                child: Center(child: Text('Belum ada transaksi. Tekan tombol Transaksi untuk menambahkan.')),
              )
            else
              ...provider.transactions.map((item) => TransactionCard(
                transaction: item,
                onEdit: () => _openForm(item: item),
                onDelete: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Hapus transaksi?'),
                      content: Text('Transaksi "${item.title}" akan dihapus.'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
                        FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Hapus')),
                      ],
                    ),
                  );
                  if (confirm == true) await provider.delete(item.id);
                },
              )),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _summary(String title, double value, String Function(double) format, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 8),
        Flexible(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(color: Colors.white70)),
          Text(format(value), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ])),
      ],
    );
  }

  Widget _message(String text, VoidCallback retry) => Column(
    children: [
      Text(text),
      TextButton.icon(onPressed: retry, icon: const Icon(Icons.refresh), label: const Text('Coba lagi')),
    ],
  );
}
