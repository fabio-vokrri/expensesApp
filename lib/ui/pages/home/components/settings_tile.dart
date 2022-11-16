import "package:flutter/material.dart";

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.function,
  }) : super(key: key);
  final String title;
  final Icon icon;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            icon,
          ],
        ),
      ),
    );
  }
}
