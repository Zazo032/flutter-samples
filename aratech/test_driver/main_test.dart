import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('AraTech driver', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      driver?.close();
    });

    test('Cambiar orden ID', () async {
      await driver.waitFor(find.text('ID'));

      await driver.tap(find.text('ID'));

      await driver.tap(find.text('ID'));
    });

    test('Abir formulario "Añadir usuario"', () async {
      await driver.waitFor(find.byType('HomeRoute'));

      await driver.waitFor(find.byType('DataTable'));

      await driver.tap(find.byType('FloatingActionButton'));

      await driver.waitFor(find.byType('UserFormRoute'));

      await driver.tap(find.byType('BackButton'));

      await driver.waitFor(find.byType('HomeRoute'));
    });

    test('Abir detalle usuario', () async {
      await driver.waitFor(find.byType('DataTable'));

      await driver.tap(find.text('1'));

      await driver.waitFor(find.byType('UserInfoRoute'));
    });

    test('Abrir formulario "Editar usuario"', () async {
      await driver.waitFor(find.byType('UserInfoRoute'));

      await driver.tap(find.byType('FloatingActionButton'));

      await driver.waitFor(find.byType('UserFormRoute'));
    });

    test('Volver a inicio', () async {
      await driver.tap(find.byType('BackButton'));

      await driver.tap(find.byType('BackButton'));
      
      await driver.waitFor(find.byType('HomeRoute'));
    });

    test('Buscar usuario', () async {
      await driver.tap(find.byTooltip(await driver.requestData('home_icon_search')));

      await driver.tap(find.byType('TextField'));

      await driver.enterText('1');

      await driver.scrollUntilVisible(find.byType('ListView'), find.byValueKey(1));

      await driver.tap(find.byValueKey(1));

      await driver.waitFor(find.byType('UserInfoRoute'));

      await driver.tap(find.byType('BackButton'));

      await driver.waitFor(find.byType('HomeRoute'));
    });
  });
}
