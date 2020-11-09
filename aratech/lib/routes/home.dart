import 'package:aratech/bloc/users_bloc/users_bloc.dart';
import 'package:aratech/bloc/users_bloc/users_event.dart';
import 'package:aratech/bloc/users_bloc/users_state.dart';
import 'package:aratech/delegates/search_delegate.dart';
import 'package:aratech/generated/l10n.dart';
import 'package:aratech/models/user.dart';
import 'package:aratech/routes/user_form.dart';
import 'package:aratech/routes/user_info.dart';
import 'package:aratech/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// La ruta inicial de [AraTechApp].
class HomeRoute extends StatefulWidget {
  /// Constructor por defecto.
  const HomeRoute();

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute>
    with SingleTickerProviderStateMixin {
  UsersBloc _bloc;
  List<User> _users;
  bool _sort;
  int _sortColumnIndex;
  DateTimeRange _dateFilter;

  @override
  void initState() {
    super.initState();
    _bloc = UsersBloc();
    _bloc.add(const LoadUsersEvent());
    _sort = true;
    _sortColumnIndex = 0;
    _users = <User>[];
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _filterData() {
    if (_dateFilter != null) {
      _users = _users.where((User _user) {
        if (_user.birthDate == null) {
          return false;
        } else {
          return _user.birthDate.isAfter(_dateFilter.start) &&
              _user.birthDate.isBefore(_dateFilter.end);
        }
      }).toList();
    }
  }

  void _sortData(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        _users.sort((User a, User b) => a.id.compareTo(b.id));
      } else {
        _users.sort((User a, User b) => b.id.compareTo(a.id));
      }
    } else if (columnIndex == 1) {
      if (ascending) {
        _users.sort((User a, User b) =>
            a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      } else {
        _users.sort((User a, User b) =>
            b.name.toLowerCase().compareTo(a.name.toLowerCase()));
      }
    } else if (columnIndex == 2) {
      if (ascending) {
        _users.sort((User a, User b) =>
            (a.birthDate ?? DateTime(0)).compareTo(b.birthDate ?? DateTime(0)));
      } else {
        _users.sort((User a, User b) =>
            (b.birthDate ?? DateTime(0)).compareTo(a.birthDate ?? DateTime(0)));
      }
    }
  }

  void _onSortColum(int columnIndex, bool ascending) {
    setState(() {
      if (_sortColumnIndex == columnIndex) {
        _sort = !_sort;
      } else {
        _sort = true;
      }
      _sortColumnIndex = columnIndex;
    });
    _sortData(columnIndex, ascending);
  }

  void _reloadUsers() => _bloc.add(const LoadUsersEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.person_add_outlined),
        label: Text(S.of(context).home_add_user),
        onPressed: () async {
          final User _user = await Navigator.push(
            context,
            MaterialPageRoute<User>(
              builder: (_) => const UserFormRoute(),
            ),
          );
          if (_user != null) {
            _reloadUsers();
          }
        },
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            title: const Text('ARATECH'),
            pinned: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search_outlined),
                tooltip: S.of(context).home_icon_search,
                onPressed: () async {
                  final User _user = await showSearch<User>(
                    context: context,
                    delegate: AraTechSearchDelegate(users: _users),
                  );
                  if (_user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => UserInfoRoute(
                          onUpdate: _reloadUsers,
                          user: _user,
                        ),
                      ),
                    );
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.date_range_outlined),
                tooltip: S.of(context).home_icon_filter_date,
                onPressed: () async {
                  final DateTimeRange _picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    initialDateRange: _dateFilter,
                  );
                  setState(() {
                    _dateFilter = _picked;
                  });
                },
              ),
            ],
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: BlocBuilder<UsersBloc, UsersState>(
              cubit: _bloc,
              builder: (_, UsersState state) {
                print(state);
                if (state is UsersLoadedState) {
                  _users = state.users;
                  _filterData();
                  _sortData(_sortColumnIndex, _sort);
                }
                return Column(
                  children: <Widget>[
                    if (state is UsersErrorState)
                      Center(
                        child: Text(S.of(context).home_error),
                      ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 250),
                      vsync: this,
                      child: state is UsersLoadingState
                          ? const LinearProgressIndicator()
                          : const SizedBox(),
                    ),
                    if (state is UsersLoadedState || _users.isNotEmpty)
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 64.0),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            showCheckboxColumn: false,
                            sortAscending: _sort,
                            sortColumnIndex: _sortColumnIndex,
                            columns: <DataColumn>[
                              DataColumn(
                                label: Text(S.of(context).home_table_column_id),
                                numeric: true,
                                onSort: _onSortColum,
                              ),
                              DataColumn(
                                label: Text(S.of(context).home_table_column_name),
                                onSort: _onSortColum,
                              ),
                              DataColumn(
                                label: Text(S.of(context).home_table_column_date),
                                onSort: _onSortColum,
                              ),
                            ],
                            rows: <DataRow>[
                              for (final User _user in _users)
                                DataRow(
                                  onSelectChanged: (_) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (_) => UserInfoRoute(
                                          onUpdate: _reloadUsers,
                                          user: _user,
                                        ),
                                      ),
                                    );
                                  },
                                  cells: <DataCell>[
                                    DataCell(
                                      Text('${_user.id}'),
                                    ),
                                    DataCell(
                                      Text(_user.name),
                                    ),
                                    if (_user.birthDate != null)
                                      DataCell(
                                        Text(_user.birthDate.formatDate()),
                                      )
                                    else
                                      const DataCell(SizedBox())
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
