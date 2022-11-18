import "package:cloud_firestore/cloud_firestore.dart";
import "package:expenses/data/models/expense_model.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/widgets.dart';

class DataBaseProvider {
  static final _userId = FirebaseAuth.instance.currentUser!.uid;
  static final collection = FirebaseFirestore.instance.collection(_userId);

  /// removes expense from firestore database
  static Future<void> removeExpense(ExpenseModel expense) async {
    await collection.doc(expense.hashCode.toString()).delete();
  }

  /// adds new expense to firestore database
  static Future<void> addExpense(ExpenseModel expense) async {
    await collection
        .doc(expense.hashCode.toString())
        .set(expense.toFirestore());
  }

  /// fetches data snapshot from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> get getSnapshot {
    return collection.snapshots();
  }

  /// returns the total amount of money spent the current month
  static double getTotalThisMonth(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.fold(0.0, (previousValue, element) {
      final ExpenseModel expense = ExpenseModel.fromFirestore(
        element as QueryDocumentSnapshot<Map<String, dynamic>>,
        null,
      );

      if (expense.isThisMonth) return previousValue += expense.amount;
      return previousValue;
    });
  }

  /// returns the total amount of money spent the current year
  static double getTotalThisYear(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.fold(0.0, (previousValue, element) {
      final ExpenseModel expense = ExpenseModel.fromFirestore(
        element as QueryDocumentSnapshot<Map<String, dynamic>>,
        null,
      );

      if (expense.isThisYear) return previousValue += expense.amount;
      return previousValue;
    });
  }

  /// returns the list of expenses from current snapshot
  static List<ExpenseModel> getExpenseList(
    AsyncSnapshot<QuerySnapshot> snapshot,
  ) {
    List<ExpenseModel> expenses = snapshot.data!.docs.map(
      (element) {
        return ExpenseModel.fromFirestore(
          element as QueryDocumentSnapshot<Map<String, dynamic>>,
          null,
        );
      },
    ).toList();

    expenses.sort(
      (a, b) => b.date.compareTo(a.date),
    );

    return expenses;
  }
}
