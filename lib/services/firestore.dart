import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreService {
//get collection from users
  final CollectionReference transaction =
      FirebaseFirestore.instance.collection('transaction');
  final CollectionReference user =
      FirebaseFirestore.instance.collection('Users');

//CREATE
  Future<void> addTransaction(String description, double amount, String date,
      String category, String payment, String type) async {
    await transaction.add({
      'description': description,
      'amount': amount,
      'date': date,
      'category': category,
      'payment': payment,
      'balance': amount,
      'type': type
    });
    if (type == 'Income') {
      await updateBalance(amount);
    } else {
      await updateBalance(-amount);
    }
  }

  //READ
  Stream<QuerySnapshot> getTransactions() {
    final transactionStream =
        transaction.orderBy('date', descending: true).snapshots();

    return transactionStream;
  }

  //UPDATE
  Future<void> updateTransaction(String docID, String description,
      double amount, String date, String category, String payment) {
    return transaction.doc(docID).update({
      'description': description,
      'amount': amount,
      'date': date,
      'category': category,
      'payment': payment,
      'balance': amount,
    });
  }

  //UPDATE BALANCE

  //DELETE
  Future<void> deleteTransaction(String docID) {
    return transaction.doc(docID).delete();
  }

  //GET TOTAL INCOME
  Future<double> totalIncome() async {
    double totalIncome = 0.0;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('transaction')
        .where('type', isEqualTo: 'Income')
        .get();

    for (var doc in querySnapshot.docs) {
      double addAmount = doc['amount'];
      totalIncome += addAmount;
    }

    return totalIncome;
  }

//GET TOTAL INCOME
  Future<double> totalExpenses() async {
    double totalExpense = 0.0;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('transaction')
        .where('docID')
        .get();

    for (var doc in querySnapshot.docs) {
      double addAmount = doc['amount'];
      totalExpense += addAmount;
    }

    return totalExpense;
  }
}

updateBalance(double amount) async {
  double totalIncome = 0.0;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('type', isEqualTo: 'Income')
        .get();

    for (var doc in querySnapshot.docs) {
      double addAmount = doc['amount'];
      totalIncome += addAmount;
    }

    return totalIncome;
}


