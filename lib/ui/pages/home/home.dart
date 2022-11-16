import "package:cloud_firestore/cloud_firestore.dart";
import "package:expenses/data/models/database_model.dart";
import "package:expenses/data/models/expense_model.dart";
import "package:expenses/ui/pages/home/components/expense_card.dart";
import "package:expenses/ui/pages/home/components/expense_form.dart";
import "package:expenses/ui/pages/home/components/settings_banner.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Ciao, ${user.displayName}"),
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const SettingsBanner();
                },
              );
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                user.photoURL!,
              ),
            ),
          ),
          const SizedBox(width: 16.0),
        ],
      ),
      body: StreamBuilder(
        stream: DataBaseModel.getSnapshot,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.size == 0) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!
                    .insertNewExpensesWIthTheButtonBelow,
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong!"),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.allExpenses),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.sort_rounded),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ListView(
                    children: snapshot.data!.docs.map(
                      (DocumentSnapshot document) {
                        return ExpenseCard(
                          expense: ExpenseModel.fromFirestore(
                            document as DocumentSnapshot<Map<String, dynamic>>,
                            null,
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
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
