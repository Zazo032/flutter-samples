import 'package:aratech/generated/l10n.dart';
import 'package:aratech/routes/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(AraTechApp());

/// Aplicación para el proceso de selección de ARATECH.
class AraTechApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ARATECH',
      home: const HomeRoute(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        S.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}