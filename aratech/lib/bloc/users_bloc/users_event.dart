import 'package:aratech/bloc/users_bloc/users_bloc.dart';
import 'package:aratech/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// Clase abstracta para representar los eventos de [UsersBloc].
abstract class UsersEvent extends Equatable {
  /// Constructor por defecto.
  const UsersEvent();

  @override
  List<Object> get props => <Object>[];
}

/// Evento en el que se carga la lista de usuarios de API.
class LoadUsersEvent extends UsersEvent {
  /// Constructor por defecto.
  const LoadUsersEvent();
}

/// Evento en el que se carga un usuario [id] de API.
class LoadUserEvent extends UsersEvent {
  /// Constructor por defecto.
  const LoadUserEvent({@required this.id})
      : assert(id != null, 'El id no puede ser nulo.');

  /// Idenficiador del [User] a obtener de API.
  final int id;

  @override
  List<Object> get props => <Object>[id];
}

/// Evento en el que se añade un usuario [id] a API.
class AddUserEvent extends UsersEvent {
  /// Constructor por defecto.
  const AddUserEvent({@required this.user})
      : assert(user != null, 'El usuario no puede ser nulo.');

  /// El usuario a añadir a API.
  final User user;

  @override
  List<Object> get props => <Object>[user];
}

/// Evento en el que se actualiza un usuario [user] de API.
class UpdateUserEvent extends UsersEvent {
  /// Constructor por defecto.
  const UpdateUserEvent({@required this.user})
      : assert(user != null, 'El usuario no puede ser nulo.');

  /// El objeto con el que actualizar el usuario en API.
  final User user;

  @override
  List<Object> get props => <Object>[user];
}
