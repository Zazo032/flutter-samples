import 'package:aratech/bloc/users_bloc/users_bloc.dart';
import 'package:aratech/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// Clase abstracta para representar un estado base de [UsersBloc].
abstract class UsersState extends Equatable {
  /// Constructor por defecto.
  const UsersState();

  @override
  List<Object> get props => <Object>[];
}

/// Estado en el que se inicializa la carga de usuarios de API.
class UsersStartState extends UsersState {}

/// Estado en el que ha ocurrido un error al cargar los usuarios.
class UsersErrorState extends UsersState {}

/// Estado en el que se están cargando los usuarios de API.
class UsersLoadingState extends UsersState {}

/// Estado en el que se está cargando un usuario de API.
class UserLoadingState extends UsersState {}

/// Estado en el que se han cargado los usuarios de API.
class UsersLoadedState extends UsersState {
  /// Constructor por defecto.
  const UsersLoadedState({@required this.users});

  /// Listado de usuarios [User] obtenido de API.
  final List<User> users;
}

/// Estado en el que se han cargado los usuarios de API.
class UserLoadedState extends UsersState {
  /// Constructor por defecto.
  const UserLoadedState({@required this.user});

  /// Usuario obtenido de API.
  final User user;
}
