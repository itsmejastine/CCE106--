import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreService {

//get collection from users
  final CollectionReference transaction =
      FirebaseFirestore.instance.collection('transaction');

//CREATE
  Future<void> addTransaction(String description, double amount, String date,
      String category, String payment, String type) {
    return transaction.add({
      'description': description,
      'amount': amount,
      'date': date,
      'category': category,
      'payment': payment,
      'balance': amount,
      'type': type
    });
  }

  //READ
  Stream<QuerySnapshot> getTransactions() {
    final transactionStream =
        transaction.orderBy('date', descending: true).snapshots();
    return transactionStream;
  }

  //READ INIDIVIDUALLY

  //UPDATE
  Future<void> updateTransaction(String docID, String description, double amount, String date,
      String category, String payment, String type) {
    return transaction.doc(docID).update({
      'description': description,
      'amount': amount,
      'date': date,
      'category': category,
      'payment': payment,
      'balance': amount,
      'type': type
    });
  }

  
}
