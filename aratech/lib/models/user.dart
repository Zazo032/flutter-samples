import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// Modelo de datos que representa a un usuario.
class User extends Equatable {
  /// Constructor por defecto.
  const User({
    @required this.id,
    @required this.name,
    @required this.birthDate,
  })  : assert(id != null, 'El identificador no puede ser nulo.'),
        assert(name != null, 'El nombre no puede ser nulo.');

  /// Construye un objecto [User] a partir de un [json] dado.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.tryParse(json['id']),
      name: json['name'],
      birthDate: DateTime.tryParse(json['birthdate']),
    );
  }

  @override
  List<Object> get props => <Object>[id, name, birthDate];

  @override
  String toString() => toJson().toString();

  /// Convierte un objeto [User] en un mapa (json) con sus valores.
  Map<String, String> toJson() {
    return <String, String>{
      'id': id.toString(),
      'name': name,
      'birthdate': birthDate?.toString(),
    };
  }

  /// El identificador del usuario.
  final int id;

  /// El nombre del ususario.
  final String name;

  /// La fecha de nacimiento del usuario.
  final DateTime birthDate;
}
