import 'package:aratech/bloc/users_bloc/users_event.dart';
import 'package:aratech/bloc/users_bloc/users_state.dart';
import 'package:aratech/models/user.dart';
import 'package:aratech/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// El [Bloc] para manejar los usuarios de la aplicación.
class UsersBloc extends Bloc<UsersEvent, UsersState> {
  /// Constructor por defecto.
  UsersBloc() : super(UsersStartState());

  @override
  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    if (event is LoadUsersEvent) {
      yield* _mapLoadUsersEventToState(event);
    } else if (event is LoadUserEvent) {
      yield* _mapLoadUserEventToState(event);
    } else if (event is AddUserEvent) {
      yield* _mapAddUserEventToState(event);
    } else if (event is UpdateUserEvent) {
      yield* _mapUpdateUserEventToState(event);
    }
  }

  Stream<UsersState> _mapLoadUsersEventToState(LoadUsersEvent event) async* {
    yield UsersLoadingState();
    final List<User> _users = await ApiService().getAllUsers();
    if (_users != null) {
      yield UsersLoadedState(users: _users);
    } else {
      yield UsersErrorState();
    }
  }

  Stream<UsersState> _mapLoadUserEventToState(LoadUserEvent event) async* {
    yield UserLoadingState();
    final User _user = await ApiService().getUser(id: event.id);
    if (_user != null) {
      yield UserLoadedState(user: _user);
    } else {
      yield UsersErrorState();
    }
  }

  Stream<UsersState> _mapAddUserEventToState(AddUserEvent event) async* {
    final bool _added = await ApiService().addUser(user: event.user);
    if (_added) {
      yield UsersLoadingState();
      final List<User> _users = await ApiService().getAllUsers();
      if (_users != null) {
        yield UsersLoadedState(users: _users);
      } else {
        yield UsersErrorState();
      }
    } else {
      yield UsersErrorState();
    }
  }

  Stream<UsersState> _mapUpdateUserEventToState(UpdateUserEvent event) async* {
    final bool _updated = await ApiService().updateUser(user: event.user);
    if (_updated) {
      yield UserLoadingState();
      final User _user = await ApiService().getUser(id: event.user.id);
      if (_user != null) {
        yield UserLoadedState(user: _user);
      } else {
        yield UsersErrorState();
      }
    } else {
      yield UsersErrorState();
    }
  }
}
