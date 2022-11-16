import "package:expenses/data/models/user_model.dart";
import "package:expenses/data/providers/language_provider.dart";
import "package:expenses/data/providers/theme_provider.dart";
import 'package:expenses/ui/pages/home/components/delete_account_dialog.dart';
import "package:expenses/ui/pages/home/components/settings_tile.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class SettingsBanner extends StatelessWidget {
  const SettingsBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;
    final ThemeProvider themeProvider = context.watch<ThemeProvider>();
    final LanguageProvider languageProvider = context.watch<LanguageProvider>();
    final double height = MediaQuery.of(context).size.height * 0.5;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      alignment: Alignment.topCenter,
      insetPadding: const EdgeInsets.only(
        top: 64.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Container(
        height: height,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(user.photoURL!),
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.displayName!),
                    Text(
                      user.email!,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await UserModel.signOut();
                  },
                  icon: const Icon(
                    Icons.exit_to_app_rounded,
                  ),
                ),
              ],
            ),
            const Divider(
              height: 32,
            ),
            SettingsTile(
              title: "Change Theme: ",
              icon: const Icon(Icons.sunny),
              function: () => themeProvider.toggleTheme(),
            ),
            SettingsTile(
              title: "Change Language: ",
              icon: const Icon(Icons.language),
              function: () => languageProvider.toggleLanguage(),
            ),
            SettingsTile(
              title: "Delete Account: ",
              icon: const Icon(Icons.person_remove_rounded),
              function: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const DeleteAccountDialog();
                  },
                );
              },
            ),
            const Spacer(),
            const Text(
              "Made with 🖤 by Fabio Vokrri",
              style: TextStyle(color: Colors.grey, fontSize: 8.0),
            ),
          ],
        ),
      ),
    );
  }
}
