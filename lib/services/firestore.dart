import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
//get collection from users
  final CollectionReference transaction =
      FirebaseFirestore.instance.collection('transaction');

  double balance = 0;
//CREATE
  Future<void> addTransaction(String description, double amount, String date,
      String category, String payment, String type) {
    return transaction.add({
      'description': description,
      'amount': amount,
      'date': date,
      'category': category,
      'payment': payment,
      'balance': balance + amount,
      'type': type
    });
  }
}
