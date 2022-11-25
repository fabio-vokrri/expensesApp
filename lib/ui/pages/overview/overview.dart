import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/data/models/expense_model.dart';
import 'package:expenses/data/providers/database_provider.dart';
import 'package:expenses/extensions/capitalize_extension.dart';
import 'package:expenses/extensions/translate_category_extension.dart';
import 'package:expenses/ui/pages/overview/components/overview_card.dart';
import 'package:expenses/ui/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  @override
  Widget build(BuildContext context) {
    AppLocalizations locale = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(
          locale.details,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(constSpace),
        child: Column(
          children: [
            for (final Category category in Category.values)
              OverviewCard(
                text: locale.localeName == "it"
                    ? category.name.translateCategory().capitalize()
                    : category.name.capitalize(),
                amount: DataBaseProvider.getTotalOfCategory(snapshot, category),
              ),
            const Divider(
              color: Colors.white,
              height: constSpace * 2,
            ),
            OverviewCard(
              text: locale.thisMonthYouSpent,
              amount: DataBaseProvider.getTotalThisMonth(snapshot),
            ),
            OverviewCard(
              text: locale.thisMonthYouGained,
              amount: DataBaseProvider.getGained(snapshot),
            ),
            OverviewCard(
              text: locale.youAreLeftWith,
              amount: DataBaseProvider.getBudget(snapshot),
            ),
          ],
        ),
      ),
    );
  }
}
