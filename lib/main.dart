import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:garson_app/app.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EasyLocalization(
      startLocale: Locale('en', 'US'),
      path: 'assets/localization',
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ar', 'DZ'),
      ],
      child: App()));
}
