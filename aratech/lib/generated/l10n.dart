// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `dd/MM/yyyy`
  String get date_format {
    return Intl.message(
      'dd/MM/yyyy',
      name: 'date_format',
      desc: '',
      args: [],
    );
  }

  /// `Añadir usuario`
  String get form_add_user {
    return Intl.message(
      'Añadir usuario',
      name: 'form_add_user',
      desc: '',
      args: [],
    );
  }

  /// `Añadir`
  String get form_add_user_action {
    return Intl.message(
      'Añadir',
      name: 'form_add_user_action',
      desc: '',
      args: [],
    );
  }

  /// `Editar usuario`
  String get form_edit_user {
    return Intl.message(
      'Editar usuario',
      name: 'form_edit_user',
      desc: '',
      args: [],
    );
  }

  /// `Editar`
  String get form_edit_user_action {
    return Intl.message(
      'Editar',
      name: 'form_edit_user_action',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de nacimiento`
  String get form_field_date {
    return Intl.message(
      'Fecha de nacimiento',
      name: 'form_field_date',
      desc: '',
      args: [],
    );
  }

  /// `Fecha no válida`
  String get form_field_date_invalid {
    return Intl.message(
      'Fecha no válida',
      name: 'form_field_date_invalid',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get form_field_id {
    return Intl.message(
      'ID',
      name: 'form_field_id',
      desc: '',
      args: [],
    );
  }

  /// `Nombre`
  String get form_field_name {
    return Intl.message(
      'Nombre',
      name: 'form_field_name',
      desc: '',
      args: [],
    );
  }

  /// `Campo obligatorio`
  String get form_required_field {
    return Intl.message(
      'Campo obligatorio',
      name: 'form_required_field',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de nacimiento: {date}`
  String info_date_span(Object date) {
    return Intl.message(
      'Fecha de nacimiento: $date',
      name: 'info_date_span',
      desc: '',
      args: [date],
    );
  }

  /// `Editar`
  String get info_edit_action {
    return Intl.message(
      'Editar',
      name: 'info_edit_action',
      desc: '',
      args: [],
    );
  }

  /// ` (ID: {id})`
  String info_id_span(Object id) {
    return Intl.message(
      ' (ID: $id)',
      name: 'info_id_span',
      desc: '',
      args: [id],
    );
  }

  /// `Información`
  String get info_title {
    return Intl.message(
      'Información',
      name: 'info_title',
      desc: '',
      args: [],
    );
  }

  /// `Añadir usuario`
  String get home_add_user {
    return Intl.message(
      'Añadir usuario',
      name: 'home_add_user',
      desc: '',
      args: [],
    );
  }

  /// `Ha ocurrido un error`
  String get home_error {
    return Intl.message(
      'Ha ocurrido un error',
      name: 'home_error',
      desc: '',
      args: [],
    );
  }

  /// `Filtrar fechas`
  String get home_icon_filter_date {
    return Intl.message(
      'Filtrar fechas',
      name: 'home_icon_filter_date',
      desc: '',
      args: [],
    );
  }

  /// `Buscar`
  String get home_icon_search {
    return Intl.message(
      'Buscar',
      name: 'home_icon_search',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de nacimiento`
  String get home_table_column_date {
    return Intl.message(
      'Fecha de nacimiento',
      name: 'home_table_column_date',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get home_table_column_id {
    return Intl.message(
      'ID',
      name: 'home_table_column_id',
      desc: '',
      args: [],
    );
  }

  /// `Nombre`
  String get home_table_column_name {
    return Intl.message(
      'Nombre',
      name: 'home_table_column_name',
      desc: '',
      args: [],
    );
  }

  /// `No hay resultados`
  String get search_no_results {
    return Intl.message(
      'No hay resultados',
      name: 'search_no_results',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}