import "package:cloud_firestore/cloud_firestore.dart";
import 'package:expenses/data/models/expense_model.dart';
import 'package:expenses/data/providers/database_provider.dart';
import 'package:expenses/ui/pages/home/components/expense_card.dart';
import "package:expenses/ui/pages/home/components/expense_form.dart";
import 'package:expenses/ui/pages/home/components/overview_banner.dart';
import "package:expenses/ui/pages/home/components/settings_banner.dart";
import 'package:expenses/ui/theme/constants.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;
    final AppLocalizations locale = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Ciao, ${user.displayName}"),
        actions: [
          GestureDetector(
            // shows settings banner
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const SettingsBanner(),
              );
            },
            child: CircleAvatar(
              radius: constRadius,
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundImage: NetworkImage(user.photoURL!),
            ),
            // child: CircleAvatar(backgroundImage: NetworkImage(user.photoURL!)),
          ),
          const SizedBox(width: constSpace),
        ],
      ),
      body: StreamBuilder(
        // listens to changes on the database and updates the UI consequently
        stream: DataBaseProvider.getSnapshot,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.size == 0) {
            // if there's no data returns a message
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_cart_outlined, size: 64),
                  const SizedBox(height: constSpace),
                  Text(locale.noExpensesToShow),
                  Text(locale.insertNewExpensesWithTheButtonBelow),
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(locale.somethingWentWrong),
            );
          } else {
            // if there's data return the UI implementation
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // overview banner where there is general expense data
                Expanded(
                  flex: 1,
                  child: OverViewBanner(snapshot: snapshot),
                ),
                Padding(
                  padding: const EdgeInsets.all(constSpace),
                  child: Text(locale.allExpenses),
                ),
                // the card view for each expense fetched from the database
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, index) {
                      final List<ExpenseModel> expenses =
                          DataBaseProvider.getExpenseList(snapshot);

                      return ExpenseCard(expense: expenses[index]);
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
      // floating action button to add new expenses to database
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
              return const ExpenseForm();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
