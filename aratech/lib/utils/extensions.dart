import 'package:aratech/generated/l10n.dart';
import 'package:intl/intl.dart';

/// Extensiones de [DateTime].
extension DateTimeFormat on DateTime {
  /// Convierte la fecha en un texto con formato [S.date_format].
  String formatDate() => DateFormat(S.current.date_format).format(this);
}

/// Extensiones de [String].
extension StringDateFormat on String {
  /// Convierte un texto con formato [S.date_format] en una fecha.
  DateTime formatDate() => DateFormat(S.current.date_format).parse(this);
}