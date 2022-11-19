import "package:expenses/data/providers/language_provider.dart";
import "package:expenses/data/providers/theme_provider.dart";
import "package:expenses/firebase_options.dart";
import "package:expenses/ui/pages/root/root.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:flutter_native_splash/flutter_native_splash.dart';
import "package:provider/provider.dart";

void main(List<String> args) async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // initializes splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // initializes FireBase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // forces device orientation to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // runs main frame
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatefulWidget {
  const ExpensesApp({super.key});

  @override
  State<ExpensesApp> createState() => _ExpensesAppState();
}

class _ExpensesAppState extends State<ExpensesApp> {
  @override
  void initState() {
    setOptimalDisplayMode();
    super.initState();
  }

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

// enables 120Hz for the devices that support it
Future<void> setOptimalDisplayMode() async {
  final List<DisplayMode> supported = await FlutterDisplayMode.supported;
  final DisplayMode active = await FlutterDisplayMode.active;

  final List<DisplayMode> sameResolution = supported.where(
    (DisplayMode m) {
      return m.width == active.width && m.height == active.height;
    },
  ).toList()
    ..sort((DisplayMode a, DisplayMode b) {
      return b.refreshRate.compareTo(a.refreshRate);
    });

  final DisplayMode mostOptimalMode =
      sameResolution.isNotEmpty ? sameResolution.first : active;

  /// This setting is per session.
  /// Please ensure this was placed with `initState` of your root widget.
  await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
}
