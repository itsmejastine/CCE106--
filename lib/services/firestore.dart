import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  User? currentUser = FirebaseAuth.instance.currentUser;

//get collection from user
  final CollectionReference userTransaction =
      FirebaseFirestore.instance.collection('Users');

//CREATE
  Future<void> addTransaction(String userID, String description, double amount,
      String date, String category, String payment, String type) async {
    await userTransaction.doc(userID).collection('transaction').add({
      'description': description,
      'amount': amount,
      'date': date,
      'category': category,
      'payment': payment,
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
    final transactionStream = userTransaction
        .doc(currentUser!.email)
        .collection('transaction')
        .orderBy('date', descending: true)
        .snapshots();

    return transactionStream;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getDocTransaction(
      String docID) {
    final docStream = userTransaction
        .doc(currentUser!.email)
        .collection('transaction')
        .doc(docID)
        .snapshots();
    return docStream;
  }

  //UPDATE
  Future<void> updateTransaction(String docID, String description,
      double amount, String date, String category, String payment) {
    return userTransaction.doc(docID).update({
      'description': description,
      'amount': amount,
      'date': date,
      'category': category,
      'payment': payment,
      'balance': amount,
    });
  }

  //DELETE
  Future<void> deleteTransaction(String docID) {
    return userTransaction.doc(docID).delete();
  }

  //GET TOTAL INCOME
  Future<double> totalIncome() async {
    double totalIncome = 0.0;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
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
        .collection('Users')
        .doc(currentUser!.email)
        .collection('transaction')
        .where('type', isEqualTo: 'Income')
        .get();

    for (var doc in querySnapshot.docs) {
      double addAmount = doc['amount'];
      totalExpense += addAmount;
    }

    return totalExpense;
  }

  updateBalance(double amount) async {
    DocumentSnapshot userBalance = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .get();

    double currentBalance = userBalance['balance'];
    double newBalance = currentBalance + (amount);

    await userTransaction.doc(currentUser!.email).update({
      'balance': newBalance,
    });
  }
}
