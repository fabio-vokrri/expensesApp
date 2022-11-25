import 'package:expenses/ui/theme/constants.dart';
import 'package:flutter/material.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({
    Key? key,
    required this.text,
    required this.amount,
  }) : super(key: key);

  final String text;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: constSpace / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: const TextStyle(color: Colors.white)),
          Text(
            "€ ${amount.toStringAsFixed(2)}",
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
