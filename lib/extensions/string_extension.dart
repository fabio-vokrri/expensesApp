import 'package:expenses/data/models/expense_model.dart';

extension TypeToStringExtension on String {
  ExpenseType toType() {
    switch (this) {
      case "grocery":
        return ExpenseType.grocery;
      case "transportation":
        return ExpenseType.transportation;
      case "entertainment":
        return ExpenseType.entertainment;
      case "education":
        return ExpenseType.education;
      case "health":
        return ExpenseType.health;
      default:
        return ExpenseType.other;
    }
  }
}
