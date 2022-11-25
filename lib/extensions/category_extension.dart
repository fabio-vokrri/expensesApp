import 'package:expenses/data/models/expense_model.dart';

extension StringToCategoryExtension on String {
  dynamic toCategory() {
    switch (this) {
      case "grocery":
        return Category.grocery;
      case "transportation":
        return Category.transportation;
      case "entertainment":
        return Category.entertainment;
      case "education":
        return Category.education;
      case "health":
        return Category.health;
      case "home":
        return Category.home;
      case "clothing":
        return Category.clothing;
      case "gift":
        return Category.gift;
      case "salary":
        return Category.salary;
      case "loan":
        return Category.loan;
      case "sale":
        return Category.sale;
      default:
        return Category.other;
    }
  }
}
