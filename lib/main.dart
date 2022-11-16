import "package:expenses/data/providers/language_provider.dart";
import "package:expenses/data/providers/theme_provider.dart";
import "package:expenses/firebase_options.dart";
import "package:expenses/ui/pages/root/root.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:provider/provider.dart";

void main(List<String> args) async {
  // forces device orientation to portrait only

  // initializes FireBase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // runs main frame
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // provides language and theme data
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      builder: (context, child) {
        final languageProvider = context.watch<LanguageProvider>();
        final themeProvider = context.watch<ThemeProvider>();
        return MaterialApp(
          title: "Expenso",
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: languageProvider.getLocale,
          theme: themeProvider.getTheme,
          home: const RootPage(),
        );
      },
    );
  }
}
