// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'es';

  static m0(date) => "Fecha de nacimiento: ${date}";

  static m1(id) => " (ID: ${id})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "date_format" : MessageLookupByLibrary.simpleMessage("dd/MM/yyyy"),
    "form_add_user" : MessageLookupByLibrary.simpleMessage("Añadir usuario"),
    "form_add_user_action" : MessageLookupByLibrary.simpleMessage("Añadir"),
    "form_edit_user" : MessageLookupByLibrary.simpleMessage("Editar usuario"),
    "form_edit_user_action" : MessageLookupByLibrary.simpleMessage("Editar"),
    "form_field_date" : MessageLookupByLibrary.simpleMessage("Fecha de nacimiento"),
    "form_field_date_invalid" : MessageLookupByLibrary.simpleMessage("Fecha no válida"),
    "form_field_id" : MessageLookupByLibrary.simpleMessage("ID"),
    "form_field_name" : MessageLookupByLibrary.simpleMessage("Nombre"),
    "form_required_field" : MessageLookupByLibrary.simpleMessage("Campo obligatorio"),
    "home_add_user" : MessageLookupByLibrary.simpleMessage("Añadir usuario"),
    "home_error" : MessageLookupByLibrary.simpleMessage("Ha ocurrido un error"),
    "home_icon_filter_date" : MessageLookupByLibrary.simpleMessage("Filtrar fechas"),
    "home_icon_search" : MessageLookupByLibrary.simpleMessage("Buscar"),
    "home_table_column_date" : MessageLookupByLibrary.simpleMessage("Fecha de nacimiento"),
    "home_table_column_id" : MessageLookupByLibrary.simpleMessage("ID"),
    "home_table_column_name" : MessageLookupByLibrary.simpleMessage("Nombre"),
    "info_date_span" : m0,
    "info_edit_action" : MessageLookupByLibrary.simpleMessage("Editar"),
    "info_id_span" : m1,
    "info_title" : MessageLookupByLibrary.simpleMessage("Información"),
    "search_no_results" : MessageLookupByLibrary.simpleMessage("No hay resultados")
  };
}
