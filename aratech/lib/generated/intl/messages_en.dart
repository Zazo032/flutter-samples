// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static m0(date) => "Birth date: ${date}";

  static m1(id) => " (ID: ${id})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "date_format" : MessageLookupByLibrary.simpleMessage("yyyy-MM-dd"),
    "form_add_user" : MessageLookupByLibrary.simpleMessage("Add user"),
    "form_add_user_action" : MessageLookupByLibrary.simpleMessage("Add"),
    "form_edit_user" : MessageLookupByLibrary.simpleMessage("Edit user"),
    "form_edit_user_action" : MessageLookupByLibrary.simpleMessage("Edit"),
    "form_field_date" : MessageLookupByLibrary.simpleMessage("Birth date"),
    "form_field_date_invalid" : MessageLookupByLibrary.simpleMessage("Invalid date"),
    "form_field_id" : MessageLookupByLibrary.simpleMessage("ID"),
    "form_field_name" : MessageLookupByLibrary.simpleMessage("Name"),
    "form_required_field" : MessageLookupByLibrary.simpleMessage("Required field "),
    "home_add_user" : MessageLookupByLibrary.simpleMessage("Add user"),
    "home_error" : MessageLookupByLibrary.simpleMessage("An error occurred"),
    "home_icon_filter_date" : MessageLookupByLibrary.simpleMessage("Date filters"),
    "home_icon_search" : MessageLookupByLibrary.simpleMessage("Search"),
    "home_table_column_date" : MessageLookupByLibrary.simpleMessage("Birth date"),
    "home_table_column_id" : MessageLookupByLibrary.simpleMessage("ID"),
    "home_table_column_name" : MessageLookupByLibrary.simpleMessage("Name"),
    "info_date_span" : m0,
    "info_edit_action" : MessageLookupByLibrary.simpleMessage("Edit"),
    "info_id_span" : m1,
    "info_title" : MessageLookupByLibrary.simpleMessage("Information"),
    "search_no_results" : MessageLookupByLibrary.simpleMessage("No results")
  };
}
