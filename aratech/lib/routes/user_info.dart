import 'package:aratech/bloc/users_bloc/users_bloc.dart';
import 'package:aratech/bloc/users_bloc/users_event.dart';
import 'package:aratech/bloc/users_bloc/users_state.dart';
import 'package:aratech/generated/l10n.dart';
import 'package:aratech/models/user.dart';
import 'package:aratech/routes/user_form.dart';
import 'package:aratech/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Ruta que muestra la información de un usuario [user].
///
/// Dicha información se actualiza con el [id] dado.
class UserInfoRoute extends StatefulWidget {
  /// Constructor por defecto.
  const UserInfoRoute({@required this.onUpdate, @required this.user, Key key})
      : assert(onUpdate != null, 'El bloc no puede ser nulo.'),
        assert(user != null, 'El id no puede ser nulo.'),
        super(key: key);

  /// El usuario del que se mostrará inicialmente la información.
  final User user;

  /// La función a llamar cuando se actualice la información de [user].
  final Function onUpdate;

  @override
  _UserInfoRouteState createState() => _UserInfoRouteState();
}

class _UserInfoRouteState extends State<UserInfoRoute>
    with SingleTickerProviderStateMixin {
  UsersBloc _bloc;
  User _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _bloc = UsersBloc();
    _bloc.add(LoadUserEvent(id: _user.id));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).info_title),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.edit_outlined),
        label: Text(S.of(context).info_edit_action),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<User>(
              builder: (_) => UserFormRoute(
                user: _user,
              ),
            ),
          ).then((User _editedUser) {
            if (_editedUser != null && _editedUser != _user) {
              widget.onUpdate();
              _bloc.add(UpdateUserEvent(user: _editedUser));
            }
          });
        },
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        cubit: _bloc,
        builder: (BuildContext context, UsersState state) {
          if (state is UserLoadedState) {
            _user = state.user;
          }
          return Column(
            children: <Widget>[
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                vsync: this,
                child: state is UserLoadingState
                    ? const LinearProgressIndicator()
                    : const SizedBox(),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    const SizedBox(height: 16.0),
                    const CircleAvatar(
                      radius: 32.0,
                      child: FlutterLogo(
                        size: 32.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Divider(),
                    const SizedBox(height: 16.0),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: _user.name,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          TextSpan(
                            text: S.of(context).info_id_span(_user.id),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                    if (_user.birthDate != null) ...<Widget>[
                      const SizedBox(height: 8.0),
                      Text(
                        S.of(context).info_date_span(_user.birthDate.formatDate()),
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center,
                      ),
                    ],
                    const SizedBox(height: 24.0),
                    const Placeholder(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
