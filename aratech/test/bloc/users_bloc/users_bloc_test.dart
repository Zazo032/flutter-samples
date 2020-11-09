import 'package:aratech/bloc/users_bloc/users_bloc.dart';
import 'package:aratech/bloc/users_bloc/users_event.dart';
import 'package:aratech/bloc/users_bloc/users_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UsersBloc', () {
    blocTest(
      'no se emiten eventos al inicializar',
      build: () => UsersBloc(),
      expect: <UsersEvent>[],
    );

    blocTest(
      'se emite la carga al cargar usuarios',
      build: () => UsersBloc(),
      act: (UsersBloc bloc) => bloc.add(const LoadUsersEvent()),
      expect: <UsersState>[
        UsersLoadingState(),
        const UsersLoadedState(users: null),
      ],
    );

    blocTest(
      'se emite la carga al cargar un usuario',
      build: () => UsersBloc(),
      act: (UsersBloc bloc) => bloc.add(const LoadUserEvent(id: 1)),
      expect: <UsersState>[
        UserLoadingState(),
        const UserLoadedState(user: null),
      ],
    );

    blocTest(
      'se emite un error al cargar un usuario no válido',
      build: () => UsersBloc(),
      act: (UsersBloc bloc) => bloc.add(const LoadUserEvent(id: 0)),
      expect: <UsersState>[
        UserLoadingState(),
        UsersErrorState(),
      ],
    );

    // Eventos de añadir y modificar usuarios modifican los valores de API.
  });
}