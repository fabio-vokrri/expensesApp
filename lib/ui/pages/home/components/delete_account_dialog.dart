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
      insetPadding: const EdgeInsets.only(bottom: constRadius * 8),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(constRadius),
      ),
      title: Text(locale.warning),
      content: Text(
        locale.areYouSureYouWantToDeleteThisAccount,
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text(locale.cancel),
        ),
        ElevatedButton(
          onPressed: UserProvider.deleteAccount,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[50],
          ),
          child: Text(
            locale.yesDeleteAccount,
            style: TextStyle(
              color: Colors.red[900],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
