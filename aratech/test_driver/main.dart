import 'package:aratech/generated/l10n.dart';
import 'package:aratech/main.dart' as app;
import 'package:flutter_driver/driver_extension.dart';


void main() {
  final DataHandler _handler = (String _key) {
    switch (_key) {
      case 'home_icon_search':
        return Future<String>.value(S.current.home_icon_search);
      default:
        return null;
    }
  };
  enableFlutterDriverExtension(handler: _handler);
  app.main();
}