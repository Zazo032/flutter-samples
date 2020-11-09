import 'dart:convert';

import 'package:aratech/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

/// Servicio para realizar conexiones con la API.
class ApiService {
  /// Constructor del singleton.
  factory ApiService() => _instance;

  ApiService._internal();

  static final ApiService _instance = ApiService._internal();

  /// La url de la API.
  @visibleForTesting
  final String apiUrl = 'https://5f0ff22d00d4ab001613446c.mockapi.io/api/v1';

  /// Obtiene la lista de todos los usuarios.
  ///
  /// Devuelve `null` si ha ocurrido un error.
  Future<List<User>> getAllUsers() async {
    final Response _response = await get('$apiUrl/user');
    if (_response.statusCode == 200) {
      final List<User> _allUsers = <User>[];
      final List<dynamic> _users = jsonDecode(_response.body);
      for (final Map<String, dynamic> _user in _users) {
        final User _parsedUser = User.fromJson(_user);
        _allUsers.add(_parsedUser);
      }
      return _allUsers;
    } else {
      return null;
    }
  }

  /// Obtiene los datos de un usuario [id] dado.
  ///
  /// Devuelve `null` si ha ocurrido un error.
  Future<User> getUser({@required int id}) async {
    assert(id != null, 'El id no puede ser nulo.');
    final Response _response = await get('$apiUrl/user/$id');
    if (_response.statusCode == 200) {
      return User.fromJson(jsonDecode(_response.body));
    } else {
      return null;
    }
  }

  /// Añade un nuevo usuario [user] a la API.
  ///
  /// Devuelve `true` si se ha añadido correctamente.
  Future<bool> addUser({@required User user}) async {
    assert(user != null, 'El usuario no puede ser nulo.');
    final Response _response = await post(
      '$apiUrl/user/',
      body: user.toJson(),
    );
    return _response.statusCode == 201;
  }

  /// Actualiza un usuario [id] en la API.
  ///
  /// Devuelve `true` si se ha actualizado correctamente.
  Future<bool> updateUser({@required User user}) async {
    assert(user != null, 'El usuario no puede ser nulo.');
    final Response _response = await put(
      '$apiUrl/user/${user.id}',
      body: user.toJson(),
    );
    return _response.statusCode == 200;
  }
}