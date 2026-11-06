import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TransactionCard({
    super.key,
    required this.transaction,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final income = transaction.isIncome;
    final money = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
        .format(transaction.amount);
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: income ? Colors.green.shade100 : Colors.red.shade100,
          child: Icon(income ? Icons.south_west : Icons.north_east,
              color: income ? Colors.green : Colors.red),
        ),
        title: Text(transaction.title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('${income ? '+' : '-'}$money\n${transaction.description}\n${DateFormat('dd MMM yyyy, HH:mm').format(transaction.createdAt)}'),
        isThreeLine: true,
        trailing: PopupMenuButton<String>(
          onSelected: (value) => value == 'edit' ? onEdit() : onDelete(),
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'edit', child: Text('Edit')),
            PopupMenuItem(value: 'delete', child: Text('Hapus')),
          ],
        ),
        titleAlignment: ListTileTitleAlignment.center,
        dense: false,
        // Nominal ditampilkan di bawah judul agar tetap terbaca pada layar kecil.
        // Prefix tanda + dan - membedakan pemasukan/pengeluaran.
        // Subtitle tambahan tidak memengaruhi data Firestore.
      ),
    );
  }
}
