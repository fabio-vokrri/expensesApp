import "package:expenses/data/providers/language_provider.dart";
import "package:expenses/data/providers/theme_provider.dart";
import 'package:expenses/data/providers/user_provider.dart';
import 'package:expenses/ui/pages/home/components/delete_account_dialog.dart';
import "package:expenses/ui/pages/home/components/settings_tile.dart";
import 'package:expenses/ui/theme/constants.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import "package:provider/provider.dart";

class SettingsBanner extends StatelessWidget {
  const SettingsBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;
    final AppLocalizations locale = AppLocalizations.of(context)!;

    final ThemeProvider themeProvider = context.watch<ThemeProvider>();
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();

    final double height = MediaQuery.of(context).size.height * 0.5;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(constRadius),
      ),
      alignment: Alignment.topCenter,
      insetPadding: const EdgeInsets.only(
        top: constSpace * 4,
        left: constSpace,
        right: constSpace,
      ),
      child: Container(
        height: height,
        padding: const EdgeInsets.all(constSpace),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(constRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: constRadius * 1.5,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  backgroundImage: NetworkImage(user.photoURL!),
                ),
                const SizedBox(width: constSpace),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.displayName!,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        user.email!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await UserProvider.signOut();
                  },
                  icon: const Icon(Icons.exit_to_app_rounded),
                  tooltip: locale.exit,
                ),
              ],
            ),
            Divider(
              height: constSpace * 2,
              thickness: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
            SettingsTile(
              title: locale.changeTheme,
              icon: const Icon(Icons.sunny),
              function: () => themeProvider.toggleTheme(),
            ),
            SettingsTile(
              title: locale.changeLanguage,
              icon: const Icon(Icons.language),
              function: () => languageProvider.toggleLanguage(),
            ),
            SettingsTile(
              title: locale.deleteAccount,
              icon: const Icon(Icons.person_remove_rounded),
              function: () {
                showDialog(
                  context: context,
                  builder: (context) => const DeleteAccountDialog(),
                );
              },
            ),
            const Spacer(),
            const Text(
              "Made with 🖤 by Fabio Vokrri",
              style: TextStyle(color: Colors.grey, fontSize: 10.0),
            ),
          ],
        ),
      ),
    );
  }
}
