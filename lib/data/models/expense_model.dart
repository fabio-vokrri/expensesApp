import "package:cloud_firestore/cloud_firestore.dart";
import "package:expenses/extensions/string_extension.dart";
import "package:flutter/material.dart";

enum ExpenseType {
  grocery,
  transportation,
  entertainment,
  education,
  health,
  other,
}

class ExpenseModel {
  final String? title;
  final double amount;
  final DateTime date;
  final ExpenseType type;

  ExpenseModel({
    this.title,
    required this.amount,
    required this.date,
    required this.type,
  });

  Map<String, dynamic> toFirestore() {
    return {
      "title": title ?? "expense",
      "amount": amount,
      "date": Timestamp.fromDate(date),
      "type": type.name,
    };
  }

  factory ExpenseModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ExpenseModel(
      title: data?["title"] as String,
      amount: data?["amount"] as double,
      date: (data?["date"] as Timestamp).toDate(),
      type: (data?["type"] as String).toType(),
    );
  }

  final Map<String, IconData> _iconMap = {
    "grocery": Icons.local_pizza,
    "transportation": Icons.train,
    "entertainment": Icons.movie,
    "education": Icons.school,
    "health": Icons.healing,
    "other": Icons.signpost,
  };

  IconData? get getIcon {
    return _iconMap[type.name];
  }

  @override
  int get hashCode => date.microsecondsSinceEpoch;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;

    return other is ExpenseModel &&
        other.title == title &&
        other.amount == amount &&
        other.date == date;
  }
}
