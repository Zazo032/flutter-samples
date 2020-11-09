import 'package:aratech/models/user.dart';
import 'package:aratech/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiService', () {
    test('Singleton', () {
      expect(ApiService(), equals(ApiService()));
    });

    test('Url regression', () {
      const String _apiUrl = 'https://5f0ff22d00d4ab001613446c.mockapi.io/api/v1';
      expect(ApiService().apiUrl, equals(_apiUrl));
    });

    group('getAllUsers', () {
      test('obtiene resultados', () async {
        final List<User> _users = await ApiService().getAllUsers();
        expect(_users, isNotNull);
        expect(_users, isNotEmpty);
      });
    });

    group('getUser', () {
      test('id no puede ser nulo', () async {
        expect(() => ApiService().getUser(id: null), throwsAssertionError);
      });

      test('obtiene un usuario', () async {
        final User _user = await ApiService().getUser(id: 1);
        expect(_user, isNotNull);
        expect(_user.id, equals(1));
      });

      test('devuelve null si no existe', () async {
        final User _user = await ApiService().getUser(id: 0);
        expect(_user, isNull);
      });
    });

    group('addUser', () {
      test('user no puede ser nulo', () async {
        expect(() => ApiService().addUser(user: null), throwsAssertionError);
      });

      test('devuelve true si se añade', () async {
        final bool _added = await ApiService().addUser(
          user: User(
            id: -1,
            name: 'TestUser',
            birthDate: DateTime.now(),
          ),
        );
        expect(_added, isTrue);
      }, skip: 'Añade un usuario en API en cada ejecución');
    });

    group('updateUser', () {
      test('user no puede ser nulo', () async {
        expect(() => ApiService().updateUser(user: null), throwsAssertionError);
      });

      test('devuelve true si se modifica', () async {
        final bool _added = await ApiService().updateUser(
          user: User(
            id: 78,
            name: 'TestUser',
            birthDate: DateTime.now(),
          ),
        );
        expect(_added, isTrue);
      });

      // Se crea un nuevo usuario en API
      test('devuelve false si no se modifica', () async {
        final bool _added = await ApiService().updateUser(
          user: User(
            id: -1,
            name: 'TestUser',
            birthDate: DateTime.now(),
          ),
        );
        expect(_added, isTrue);
      }, skip: 'Al editar un usuario con id no encontrada, lo añade en API');
    });
  });
}