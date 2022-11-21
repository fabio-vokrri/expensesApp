import "package:cloud_firestore/cloud_firestore.dart";
import 'package:expenses/extensions/type_extension.dart';
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
  final int id;
  final String? title;
  final double amount;
  final DateTime date;
  final ExpenseType type;

  ExpenseModel({
    this.title,
    required this.amount,
    required this.date,
    required this.type,
    required this.id,
  });

  Map<String, dynamic> toFirestore() {
    return {
      "title": title ?? "expense",
      "amount": amount,
      "date": Timestamp.fromDate(date),
      "type": type.name,
      "id": id,
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
      id: data?["id"] as int,
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

  bool get isThisMonth {
    return date.month == DateTime.now().month &&
        date.year == DateTime.now().year;
  }

  bool get isThisYear {
    return date.year == DateTime.now().year;
  }

  ExpenseModel copyWith({
    String? title,
    double? amount,
    DateTime? date,
    ExpenseType? type,
  }) {
    return ExpenseModel(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      type: type ?? this.type,
      id: id,
    );
  }

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is ExpenseModel &&
        other.title == title &&
        other.amount == amount &&
        other.date == date &&
        other.type == type &&
        other.id == id;
  }
}
