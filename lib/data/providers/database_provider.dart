import "package:cloud_firestore/cloud_firestore.dart";
import "package:expenses/data/models/expense_model.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/widgets.dart';

class DataBaseProvider {
  static final _userId = FirebaseAuth.instance.currentUser!.uid;
  static final collection = FirebaseFirestore.instance.collection(_userId);

  /// removes expense from firestore database
  static Future<void> removeExpense(ExpenseModel expense) async {
    await collection.doc(expense.id.toString()).delete();
  }

  /// adds new expense to firestore database
  static Future<void> addExpense(ExpenseModel expense) async {
    await collection.doc(expense.id.toString()).set(expense.toFirestore());
  }

  /// fetches data snapshot from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> get getSnapshot {
    return collection.snapshots();
  }

  /// returns the total amount of money spent the current month
  static double getTotalThisMonth(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.fold(0.0, (previousValue, element) {
      final ExpenseModel expense = ExpenseModel.fromFirestore(
        snapshot: element as QueryDocumentSnapshot<Map<String, dynamic>>,
      );

      if (expense.isThisMonth && expense.type == Type.loss) {
        return previousValue += expense.amount;
      }

      return previousValue;
    });
  }

  /// returns the total amount of money spent the current year
  static double getTotalThisYear(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.fold(0.0, (previousValue, element) {
      final ExpenseModel expense = ExpenseModel.fromFirestore(
        snapshot: element as QueryDocumentSnapshot<Map<String, dynamic>>,
      );

      if (expense.isThisYear && expense.type == Type.loss) {
        return previousValue += expense.amount;
      }

      return previousValue;
    });
  }

  static double getTotalOfCategory(
    AsyncSnapshot<QuerySnapshot> snapshot,
    Category category,
  ) {
    return snapshot.data!.docs.fold(0.0, (previousValue, element) {
      final ExpenseModel expense = ExpenseModel.fromFirestore(
        snapshot: element as QueryDocumentSnapshot<Map<String, dynamic>>,
      );

      if (expense.isThisMonth && expense.category == category) {
        return previousValue += expense.amount;
      }
      return previousValue;
    });
  }

  /// returns the total amount of money available to be spent
  static double getBudget(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.fold(0.0, (previousValue, element) {
      final ExpenseModel expense = ExpenseModel.fromFirestore(
        snapshot: element as QueryDocumentSnapshot<Map<String, dynamic>>,
      );

      if (expense.type == Type.gain) return previousValue += expense.amount;
      return previousValue -= expense.amount;
    });
  }

  static double getGained(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.fold(0.0, (previousValue, element) {
      final ExpenseModel expense = ExpenseModel.fromFirestore(
        snapshot: element as QueryDocumentSnapshot<Map<String, dynamic>>,
      );

      if (expense.isThisMonth && expense.type == Type.gain) {
        return previousValue += expense.amount;
      }
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
          snapshot: element as QueryDocumentSnapshot<Map<String, dynamic>>,
        );
      },
    ).toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    return expenses;
  }
}
