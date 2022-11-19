import 'package:expenses/data/models/expense_model.dart';
import 'package:expenses/data/providers/database_provider.dart';
import 'package:expenses/ui/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteExpenseDialog extends StatelessWidget {
  const DeleteExpenseDialog({
    Key? key,
    required this.expense,
  }) : super(key: key);

  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(constRadius),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      title: Text(locale.warning),
      content: Text(
        locale.areYouSureYouWantToDeleteThisExpense,
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text(locale.cancel),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.error,
          ),
          onPressed: () {
            DataBaseProvider.removeExpense(expense);
            Navigator.pop(context);
          },
          child: Text(
            locale.yesDeleteExpense,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
