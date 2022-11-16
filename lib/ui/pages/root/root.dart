import "package:expenses/ui/pages/error/error.dart";
import "package:expenses/ui/pages/pages.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    // listens to auth changes and reroutes the frame
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          // if user signed returns home page
          return const HomePage();
        } else if (snapshot.hasError) {
          return ErrorPage(error: snapshot.error!);
        } else {
          // if user not signed in return auth page
          return const AuthPage();
        }
      },
    );
  }
}
