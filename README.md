# EXPENSO

Expenso is an expense tracking app that uses Google authentication to store your information safely.  

## Steps for running the app on your Android device

First of all, in order to run this application in your device you need the Flutter SDK installed on your computer. To install Flutter follow the instructions at <https://docs.flutter.dev/get-started/install>.  

Once you installed Flutter and Android Studio, you need to activate the Developer Options on your smartphone: follow the instructions on <https://developer.android.com/studio/debug/dev-options> and enable USB Debugging. Now connect your smartphone to your computer via USB cable (or via adb commands - all explained in the previous link) and all should be ready to run the app.  

So, clone this repository on your Android Studio IDE and type the following commands in the terminal:

```bash
flutter clean
flutter pub get
flutter run --release
```

The `flutter clean` command deletes all the build files created on previous sessions and is sometimes used as a last resort solution when there are some Gradle bugs (the worst ones).  
The `flutter pub get` command gets all the required packages listed in the `pubspec.yaml` in order for the application to run.
The last command, `flutter run --release`, is self explanatory as it runs the application in release mode.

Now the application should be running on your connected device. Play with it and try to find some bugs! If so, please open a new issue report and I will try my best to fix it.
