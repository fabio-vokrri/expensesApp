import "package:expenses/data/models/database_model.dart";
import "package:expenses/data/models/expense_model.dart";
import "package:expenses/extensions/string_extension.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:intl/intl.dart";

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({
    Key? key,
  }) : super(key: key);

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime? _date;
  String _type = ExpenseType.grocery.name;

  _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );

    setState(() {
      _date = pickedDate;
    });
  }

  // validates the form fields and creates a new expense to add to the database
  _validateAndAddToDatabase() {
    if (_formKey.currentState!.validate()) {
      // creates new expense
      final ExpenseModel expense = ExpenseModel(
        title: _titleController.text.isEmpty
            ? AppLocalizations.of(context)!.expense
            : _titleController.text,
        amount: double.parse(_amountController.text),
        date: _date ?? DateTime.now(),
        type: _type.toType(),
      );

      // adds expense to database
      DataBaseModel.addExpense(expense);

      // pops context to return to home page
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return "Insert Amount";
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Text(
                  _date != null
                      ? DateFormat.yMMMMd("it").format(_date!)
                      : "Select Date",
                ),
                const Spacer(),
                IconButton(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text("Select Category"),
                const Spacer(),
                DropdownButton(
                  items: ExpenseType.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.name,
                          child: Text(e.name),
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
            const SizedBox(height: 32.0),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("Add Expense"),
              onPressed: _validateAndAddToDatabase,
            )
          ],
        ),
      ),
    );
  }
}
