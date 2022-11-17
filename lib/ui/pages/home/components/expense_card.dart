import "package:expenses/data/models/expense_model.dart";
import 'package:expenses/data/providers/database_provider.dart';
import "package:flutter/material.dart";
import "package:intl/intl.dart";

class ExpenseCard extends StatelessWidget {
  final ExpenseModel expense;

  const ExpenseCard({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16.0,
        right: 16.0,
      ),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 8,
            offset: const Offset(8, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            foregroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: Icon(expense.getIcon),
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                expense.title!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                DateFormat.yMd("it").format(expense.date),
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            "€${expense.amount.toStringAsFixed(2)}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () => DataBaseModel.removeExpense(expense),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
