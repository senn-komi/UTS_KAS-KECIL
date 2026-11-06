import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/transaction_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _transactions =>
      _db.collection('transactions');

  Stream<List<TransactionModel>> streamTransactions(String uid) {
    return _transactions.where('owner', isEqualTo: uid).snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => TransactionModel.fromMap(doc.id, doc.data()))
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
    );
  }

  Future<List<TransactionModel>> getTransactions(String uid) async {
    final snapshot = await _transactions.where('owner', isEqualTo: uid).get();
    final result = snapshot.docs
        .map((doc) => TransactionModel.fromMap(doc.id, doc.data()))
        .toList();
    result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return result;
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    await _transactions.add(transaction.toMap());
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    await _transactions.doc(transaction.id).update(transaction.toMap());
  }

  Future<void> deleteTransaction(String id) async {
    await _transactions.doc(id).delete();
  }
}
