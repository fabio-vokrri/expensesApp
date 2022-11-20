import 'dart:io';

import 'package:expenses/data/providers/user_provider.dart';
import 'package:expenses/ui/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;

    return AlertDialog(
      insetPadding: const EdgeInsets.only(
        left: constSpace,
        right: constSpace,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(constRadius),
      ),
      title: Text(locale.warning),
      content: Text(locale.areYouSureYouWantToDeleteThisAccount),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text(locale.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            UserProvider.deleteAccount;
            exit(0);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
          child: Text(
            locale.yesDeleteAccount,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
