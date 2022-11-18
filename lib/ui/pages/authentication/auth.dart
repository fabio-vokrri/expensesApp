import 'package:expenses/data/providers/user_provider.dart';
import 'package:expenses/ui/theme/constants.dart';
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:flutter_native_splash/flutter_native_splash.dart';

class AuthPage extends StatelessWidget {
  // static const String routeName = "/auth";
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    // removes splash screen
    FlutterNativeSplash.remove();

    final AppLocalizations locale = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Icon(
              Icons.account_balance,
              size: 90,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: constSpace * 16),
                Text(
                  locale.welcomeToExpenso,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  locale.toKeepTrackOfYourExpenses,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: constSpace),
                ElevatedButton.icon(
                  onPressed: () async => await UserProvider.signInWithGoogle(),
                  icon: Image.asset(
                    "assets/images/google.png",
                    height: 24,
                  ),
                  label: Text(locale.logInWithGoogle),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
