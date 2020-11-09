import 'dart:ui';

import 'package:aratech/generated/l10n.dart';
import 'package:aratech/utils/extensions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  group('DateTimeFormat', () {

    setUpAll(() {
      initializeDateFormatting('es');
      S.load(const Locale('es'));
    });

    test('Formato correcto', () {
      final DateTime _date = DateTime.utc(1997, 6, 9);
      expect(_date.formatDate(), equals('09/06/1997'));
    });
  });

  group('StringDateFormat', () {
    test('Formato correcto', () {
      const String _date = '09/06/1997';
      expect(_date.formatDate(), equals(DateTime(1997, 6, 9)));
      const String _date2 = '9/6/1997';
      expect(_date2.formatDate(), equals(DateTime(1997, 6, 9)));
    });

    test('Lanza excepción si no tiene un formato correcto', () {
      const String _date = 'test';
      dynamic _error;
      try {
        _date.formatDate();
      } catch (e) {
        _error = e;
      } finally {
        expect(_error, isNotNull);
        expect(_error, isA<FormatException>());
      }
    });
  });
}