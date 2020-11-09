import 'package:aratech/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    final User _user = User(
      id: 1,
      name: 'Test',
      birthDate: DateTime(2020, 02, 01),
    );
    final Map<String, dynamic> _userMapped = <String, dynamic>{
      'id': '1',
      'name': 'Test',
      'birthdate': '2020-02-01 00:00:00.000',
    };

    test('id no puede ser nulo', () async {
      expect(
        () => User(id: null, name: 'Nombre', birthDate: DateTime.now()),
        throwsAssertionError,
      );
    });

    test('name no puede ser nulo', () async {
      expect(
        () => User(id: -1, name: null, birthDate: DateTime.now()),
        throwsAssertionError,
      );
    });

    test('fromJson', () {
      expect(_user, User.fromJson(_userMapped));
    });

    test('toJson', () {
      expect(_user.toJson(), _userMapped);
    });

    test('toString', () {
      expect(_user.toString(), _user.toJson().toString());
    });
  });
}
