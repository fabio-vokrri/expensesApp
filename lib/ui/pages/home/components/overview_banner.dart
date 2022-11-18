import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/data/providers/database_provider.dart';
import 'package:expenses/ui/painters/overview_progressbar_painter.dart.dart';
import 'package:expenses/ui/theme/constants.dart';
import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OverViewBanner extends StatelessWidget {
  const OverViewBanner({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: constSpace,
        vertical: constSpace,
      ),
      padding: const EdgeInsets.all(constSpace),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(constRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 8,
            offset: const Offset(8, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomPaint(
            size: Size(size.width / 3, size.width / 3),
            painter: OverviewProgressBar(
              percentage: DataBaseProvider.getTotalThisMonth(snapshot) /
                  DataBaseProvider.getTotalThisYear(snapshot),
              backgroundColor: Colors.white10,
              color: Colors.white,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                locale.thisMonthYouSpent,
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                "€ ${DataBaseProvider.getTotalThisMonth(snapshot).toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: constSpace),
              Text(
                locale.thisYearYouSpent,
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                "€ ${DataBaseProvider.getTotalThisYear(snapshot).toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
