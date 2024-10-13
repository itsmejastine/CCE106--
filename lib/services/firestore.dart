import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  //Checks if then user logs in or not
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

  //READS ALL THE TRANSACTIONS
  Stream<QuerySnapshot> getTransactions() {
    final transactionStream = userTransaction
        .doc(currentUser!.email)
        .collection('transaction')
        .orderBy('date', descending: true)
        .snapshots();

    return transactionStream;
  }

//READ TRANSACTION BASED ON THE DOCUMENT ID
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
      double newAmount, String date, String category, String payment) async {
    DocumentSnapshot previousTransaction = await userTransaction
        .doc(currentUser!.email)
        .collection('transaction')
        .doc(docID)
        .get();
    double previousAmount = previousTransaction['amount'];
    String type = previousTransaction['type'];

    await userTransaction
        .doc(currentUser!.email)
        .collection('transaction')
        .doc(docID)
        .update({
      'description': description,
      'amount': newAmount,
      'date': date,
      'category': category,
      'payment': payment,
    });
    //based on the type of transaction,
    //the difference of the previousAmount and the newAmount will be use to update then balance
    double amountDifference = newAmount - previousAmount;
    if (type == 'Income') {
      await updateBalance(amountDifference);
    } else {
      await updateBalance(-amountDifference);
    }

    return;
  }

  //DELETE
  Future<void> deleteTransaction(String docID) async {
    DocumentSnapshot previousTransaction = await userTransaction
        .doc(currentUser!.email)
        .collection('transaction')
        .doc(docID)
        .get();

    double amount = previousTransaction['amount'];
    String type = previousTransaction['type'];

    await userTransaction
        .doc(currentUser!.email)
        .collection('transaction')
        .doc(docID)
        .delete();

    //based on the type of transaction,
    //the difference of the previousAmount and the newAmount will be use to update then balance
    if (type == 'Income') {
      await updateBalance(-amount);
    } else {
      await updateBalance(amount);
    }

    return;
  }

  //GET TOTAL INCOME
  Future<double> totalIncome() async {
    double totalIncome = 0.0;
    //fetches documents of the current user where the type of transaction is 'Income'
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .collection('transaction')
        .where('type', isEqualTo: 'Income')
        .get();

    //gets the amount for each elements and updates the total income
    for (var doc in querySnapshot.docs) {
      double addAmount = doc['amount'];
      totalIncome += addAmount;
    }

    return totalIncome;
  }

//GET TOTAL EXPENSES
  Future<double> totalExpenses() async {
    double totalExpense = 0.0;
    //fetches documents of the current user where the type of transaction is 'Expenses'
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .collection('transaction')
        .where('type', isEqualTo: 'Expenses')
        .get();

    //gets the amount for each elements and updates the total expenses
    for (var doc in querySnapshot.docs) {
      double addAmount = doc['amount'];
      totalExpense += addAmount;
    }

    return totalExpense;
  }

  //GET the total balance
  Future<double> userBalance() async {
    DocumentSnapshot<Map<String, dynamic>> currentBalance =
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser!.email)
            .get();

    double balance = currentBalance['balance'];

    return balance;
  }

//UPDATES the balancae
  updateBalance(double amount) async {
    DocumentSnapshot userBalance = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .get();

    //fetches the current Balance of the current use
    double currentBalance = userBalance['balance'];
    //curent balance and the amount will be added
    double newBalance = currentBalance + (amount);

    //updates the balance in the firestore
    await userTransaction.doc(currentUser!.email).update({
      'balance': newBalance,
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  Future<int> getTotalTransaction() async {
    QuerySnapshot<Map<String, dynamic>> totalTransactions =
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser!.email)
            .collection('transaction')
            .get();

    return totalTransactions.size;
  }
}
