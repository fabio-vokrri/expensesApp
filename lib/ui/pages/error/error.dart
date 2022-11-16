import "package:flutter/material.dart";

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.error});
  final Object error;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Some error occurred!")),
    );
  }
}
