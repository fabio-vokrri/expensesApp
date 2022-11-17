import 'package:expenses/data/models/user_model.dart';
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
      insetPadding: const EdgeInsets.only(bottom: 128.0),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
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
          onPressed: UserModel.deleteAccount,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
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
