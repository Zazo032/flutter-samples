import 'package:aratech/generated/l10n.dart';
import 'package:aratech/models/user.dart';
import 'package:flutter/material.dart';

/// Delegado para realizar la búsqueda y filtro de usuarios.
class AraTechSearchDelegate extends SearchDelegate<User> {
  /// Constructor por defecto.
  AraTechSearchDelegate({@required this.users});

  /// Lista de usuarios sobre la que buscar.
  final List<User> users;

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) => const BackButton();

  @override
  Widget buildResults(BuildContext context) {
    final List<User> _searchedUsers = users
        .where((User user) =>
            user.name.toLowerCase().contains(query.toLowerCase()) ||
            user.id.toString().contains(query))
        .toList();
    if (query.isEmpty || _searchedUsers.isEmpty) {
      return Center(
        child: Text(S.of(context).search_no_results),
      );
    } else {
      return ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        itemCount: _searchedUsers.length,
        itemBuilder: (BuildContext context, int index) {
          final User _user = _searchedUsers[index];
          return ListTile(
            key: ValueKey<int>(_user.id),
            leading: CircleAvatar(
              child: Text('${_user.id}'),
            ),
            title: Text(_user.name),
            onTap: () => close(context, _user),
          );
        },
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const SizedBox();
    } else {
      final List<User> _searchedUsers = users
          .where((User user) =>
              user.name.toLowerCase().contains(query.toLowerCase()) ||
              user.id.toString().contains(query))
          .toList();
      return ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        itemCount: _searchedUsers.length,
        itemBuilder: (BuildContext context, int index) {
          final User _user = _searchedUsers[index];
          return ListTile(
            key: ValueKey<int>(_user.id),
            leading: CircleAvatar(
              child: Text('${_user.id}'),
            ),
            title: Text(_user.name),
            onTap: () => close(context, _user),
          );
        },
      );
    }
  }
}
