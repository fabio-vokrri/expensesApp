import "package:cloud_firestore/cloud_firestore.dart";
import 'package:expenses/extensions/category_extension.dart';
import 'package:expenses/extensions/type_extension.dart';
import "package:flutter/material.dart";

enum Category {
  salary(Type.gain),
  sale(Type.gain),
  loan(Type.gain),
  grocery(Type.loss),
  home(Type.loss),
  health(Type.loss),
  education(Type.loss),
  transportation(Type.loss),
  entertainment(Type.loss),
  clothing(Type.loss),
  gift(Type.loss),
  other(Type.loss);

  final Type type;
  const Category(this.type);
}

enum Type { gain, loss }

class ExpenseModel {
  final int id;
  final String? title;
  final double amount;
  final DateTime date;
  final Category category;
  final Type type;

  ExpenseModel({
    this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.type,
    required this.id,
  });

  Map<String, dynamic> toFirestore() {
    return {
      "title": title ?? "expense",
      "amount": amount,
      "date": Timestamp.fromDate(date),
      "category": category.name,
      "type": type.name,
      "id": id,
    };
  }

  factory ExpenseModel.fromFirestore({
    required DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    return ExpenseModel(
      title: data?["title"] as String,
      amount: data?["amount"] as double,
      date: (data?["date"] as Timestamp).toDate(),
      category: (data?["category"] as String).toCategory(),
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
    "home": Icons.home,
    "clothing": Icons.checkroom,
    "gift": Icons.card_giftcard,
    "loan": Icons.rotate_left,
    "salary": Icons.wallet,
    "sale": Icons.sync_alt_outlined,
    "other": Icons.signpost,
  };

  IconData? get getIcon => _iconMap[category.name];

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
    Category? category,
    Type? type,
  }) {
    return ExpenseModel(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
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
        other.category == category &&
        other.id == id;
  }
}
