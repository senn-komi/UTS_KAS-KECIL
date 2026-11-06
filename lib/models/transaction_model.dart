import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final String type;
  final String description;
  final DateTime createdAt;
  final String owner;

  const TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.description,
    required this.createdAt,
    required this.owner,
  });

  bool get isIncome => type == 'income';

  factory TransactionModel.fromMap(String id, Map<String, dynamic> map) {
    final rawDate = map['createdAt'];
    return TransactionModel(
      id: id,
      title: map['title'] as String? ?? '',
      amount: (map['amount'] as num? ?? 0).toDouble(),
      type: map['type'] as String? ?? 'expense',
      description: map['description'] as String? ?? '',
      createdAt: rawDate is Timestamp ? rawDate.toDate() : DateTime.now(),
      owner: map['owner'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'amount': amount,
        'type': type,
        'description': description,
        'createdAt': Timestamp.fromDate(createdAt),
        'owner': owner,
      };
}
