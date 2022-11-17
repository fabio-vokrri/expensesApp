import 'package:expenses/data/providers/database_provider.dart';
import 'package:expenses/ui/painters/overview_progressbar_painter.dart.dart';
import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OverViewBanner extends StatelessWidget {
  const OverViewBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 8,
            offset: const Offset(8, 8),
          ),
        ],
      ),
      child: StreamBuilder(
        stream: DataBaseModel.getSnapshot,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(locale.somethingWentWrong),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomPaint(
                  size: const Size(100, 100),
                  painter: OverviewProgressBar(
                    percentage: DataBaseModel.getTotalThisMonth(snapshot) /
                        DataBaseModel.getTotalThisYear(snapshot) *
                        100,
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
                      "€ ${DataBaseModel.getTotalThisMonth(snapshot).toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      locale.thisYearYouSpent,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "€ ${DataBaseModel.getTotalThisYear(snapshot).toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
