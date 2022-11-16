import "package:cloud_firestore/cloud_firestore.dart";
import "package:expenses/data/models/expense_model.dart";
import "package:firebase_auth/firebase_auth.dart";

class DataBaseModel {
  static final collection = FirebaseFirestore.instance.collection(
    FirebaseAuth.instance.currentUser!.uid,
  );

  static final List<ExpenseModel> _thisMonthExpenses = [];

  static Future<void> removeExpense(ExpenseModel expense) async {
    await collection.doc(expense.hashCode.toString()).delete();
  }

  static Future<void> addExpense(ExpenseModel expense) async {
    await collection
        .doc(expense.hashCode.toString())
        .set(expense.toFirestore());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> get getSnapshot {
    return collection.snapshots();
  }

  static double getTotalThisMonth() {
    return _thisMonthExpenses.fold(0.0, (previousValue, element) {
      return previousValue + element.amount;
    });
  }

  static Future<double> getTotalThisYear() async {
    return 0;
  }
}
