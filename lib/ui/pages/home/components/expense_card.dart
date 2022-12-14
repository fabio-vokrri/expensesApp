import "package:expenses/data/models/expense_model.dart";
import 'package:expenses/ui/pages/home/components/delete_expense_dialog.dart';
import 'package:expenses/ui/pages/home/components/expense_form.dart';
import 'package:expenses/ui/theme/constants.dart';
import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import "package:intl/intl.dart";

class ExpenseCard extends StatelessWidget {
  final ExpenseModel expense;

  const ExpenseCard({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(constRadius),
              topRight: Radius.circular(constRadius),
            ),
          ),
          builder: (context) {
            return ExpenseForm(
              expense: expense,
              expenseType: expense.type,
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: constSpace,
          right: constSpace,
        ),
        padding: const EdgeInsets.all(constSpace),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(constRadius),
            topRight: Radius.circular(constRadius),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 8,
              offset: const Offset(8, 8),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.scaffoldBackgroundColor,
              child: Icon(expense.getIcon),
            ),
            const SizedBox(width: constSpace),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(expense.title!),
                Text(
                  DateFormat.yMd(locale.localeName).format(expense.date),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            Text("??? ${expense.amount.toStringAsFixed(2)}"),
            const SizedBox(width: constSpace),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => DeleteExpenseDialog(expense: expense),
                );
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
