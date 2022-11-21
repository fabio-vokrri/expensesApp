import "package:expenses/data/models/expense_model.dart";
import 'package:expenses/data/providers/database_provider.dart';
import 'package:expenses/extensions/capitalize_extension.dart';
import 'package:expenses/extensions/translate_type_extension.dart';
import 'package:expenses/extensions/type_extension.dart';
import 'package:expenses/ui/theme/constants.dart';
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:intl/intl.dart";

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({
    Key? key,
    this.expense,
  }) : super(key: key);

  final ExpenseModel? expense;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late DateTime? _date;
  late String _type;

  @override
  void initState() {
    _titleController = TextEditingController(
      text: widget.expense == null ? null : widget.expense!.title,
    );
    _amountController = TextEditingController(
      text: widget.expense == null
          ? null
          : widget.expense!.amount.toStringAsFixed(2),
    );

    _date = widget.expense == null ? null : widget.expense!.date;
    _type = widget.expense == null
        ? ExpenseType.grocery.name
        : widget.expense!.type.name;

    super.initState();
  }

  // picks the date
  _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    setState(() {
      _date = pickedDate;
    });
  }

  // validates the form fields and creates a new expense,
  // or modifies the one passed as argument, to add to the database
  _validateAndAddToDatabase() {
    if (_formKey.currentState!.validate()) {
      final ExpenseModel expense;

      if (widget.expense != null) {
        // modifies the existing expense
        expense = widget.expense!.copyWith(
          title: _titleController.text.isEmpty
              ? AppLocalizations.of(context)!.expense.capitalize()
              : _titleController.text.capitalize(),
          amount: double.parse(_amountController.text),
          date: _date ?? DateTime.now(),
          type: _type.toType(),
        );
      } else {
        // creates new expense
        expense = ExpenseModel(
          title: _titleController.text.isEmpty
              ? AppLocalizations.of(context)!.expense.capitalize()
              : _titleController.text.capitalize(),
          amount: double.parse(_amountController.text),
          date: _date ?? DateTime.now(),
          type: _type.toType(),
          id: DateTime.now().microsecondsSinceEpoch,
        );
      }

      // adds expense to database
      DataBaseProvider.addExpense(expense);

      // pops context to return to home page
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(constSpace),
      height: size.height * 0.8,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                Container(
                  height: 4,
                  width: size.width / 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(constRadius),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: constSpace),
            TextFormField(
              controller: _titleController,
              style: theme.textTheme.labelSmall,
              decoration: InputDecoration(labelText: locale.title),
            ),
            const SizedBox(height: constSpace),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: theme.textTheme.labelSmall,
              decoration: InputDecoration(labelText: locale.amount),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return locale.insertAmount;
                }
                return null;
              },
            ),
            const SizedBox(height: constSpace),
            Row(
              children: [
                Text(
                  _date != null
                      ? DateFormat.yMMMMd(locale.localeName).format(_date!)
                      : locale.date,
                ),
                const Spacer(),
                IconButton(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
            const SizedBox(height: constSpace),
            Row(
              children: [
                Text(locale.category),
                const Spacer(),
                DropdownButton(
                  items: ExpenseType.values
                      .map(
                        (expenseTypeValue) => DropdownMenuItem(
                          value: expenseTypeValue.name,
                          child: Text(
                            locale.localeName == "it"
                                ? expenseTypeValue.name
                                    .translateType()
                                    .capitalize()
                                : expenseTypeValue.name.capitalize(),
                            style: theme.textTheme.labelSmall,
                          ),
                        ),
                      )
                      .toList(),
                  value: _type,
                  onChanged: (value) {
                    setState(() {
                      _type = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: constSpace * 2),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: Text(
                widget.expense == null
                    ? locale.addExpense
                    : locale.modifyExpense,
              ),
              onPressed: _validateAndAddToDatabase,
            )
          ],
        ),
      ),
    );
  }
}
