import "package:expenses/data/models/user_model.dart";
import "package:expenses/data/providers/language_provider.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:provider/provider.dart";

class AuthPage extends StatelessWidget {
  static const String routeName = "/auth";
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    final AppLocalizations locale = AppLocalizations.of(context)!;

    const String walletAssetLocation = "assets/images/google.png";
    const String googleAssetLocation = "assets/images/google.png";

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              walletAssetLocation,
              height: 100,
            ),
            const SizedBox(height: 32.0),
            Text(
              locale.welcomeToExpenso,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton.icon(
              onPressed: () async {
                await UserModel.signInWithGoogle();
              },
              label: Text(locale.logInWithGoogle),
              icon: Image.asset(
                googleAssetLocation,
                height: 16.0,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                languageProvider.toggleLanguage();
              },
              icon: const Icon(Icons.language),
              label: Text(
                languageProvider.getLocale.languageCode.toUpperCase(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
