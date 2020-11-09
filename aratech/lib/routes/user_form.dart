import 'package:aratech/generated/l10n.dart';
import 'package:aratech/models/user.dart';
import 'package:aratech/utils/extensions.dart';
import 'package:flutter/material.dart';

/// La ruta con el formulario para añdir o editar usuarios.
///
/// Si [user] es nulo, el formulario será para añadir un usuario.
class UserFormRoute extends StatefulWidget {
  /// Constructor por defecto.
  const UserFormRoute({this.user, Key key}) : super(key: key);

  /// El usuario a editar.
  final User user;

  @override
  _UserFormRouteState createState() => _UserFormRouteState();
}

class _UserFormRouteState extends State<UserFormRoute> {
  GlobalKey<FormState> _formKey;
  TextEditingController _idController, _nameController, _dateController;

  bool get _isAddUser => widget.user == null;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _idController = TextEditingController(text: widget.user?.id.toString());
    _nameController = TextEditingController(text: widget.user?.name);
    _dateController = TextEditingController();
    if (widget.user?.birthDate != null) {
      _dateController.text = widget.user.birthDate.formatDate();
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final User _user = User(
        id: int.tryParse(_idController.text) ?? -1,
        name: _nameController.text,
        birthDate: _dateController.text.formatDate(),
      );
      Navigator.maybePop(context, _user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isAddUser
              ? S.of(context).form_add_user
              : S.of(context).form_edit_user,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(_isAddUser ? Icons.add : Icons.save_outlined),
        label: Text(
          _isAddUser
              ? S.of(context).form_add_user_action
              : S.of(context).form_edit_user_action,
        ),
        onPressed: _handleSave,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (_) => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(16.0),
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              if (!_isAddUser) ...<Widget>[
                TextFormField(
                  controller: _idController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: S.of(context).form_field_id,
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
              TextFormField(
                autofillHints: const <String>[
                  AutofillHints.name,
                ],
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: S.of(context).form_field_name,
                ),
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                validator: (String _value) {
                  if (_value.isEmpty) {
                    return S.of(context).form_required_field;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: S.of(context).form_field_date,
                ),
                readOnly: true,
                onTap: () async {
                  final DateTime _selectedDate = await showDatePicker(
                    context: context,
                    initialDate: widget.user?.birthDate ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (_selectedDate != null) {
                    setState(() {
                      _dateController.text = _selectedDate.formatDate();
                    });
                  }
                },
                validator: (String _value) {
                  if (_value.isEmpty) {
                    return S.of(context).form_required_field;
                  }
                  try {
                    _value.formatDate();
                  } on FormatException {
                    return S.of(context).form_field_date_invalid;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
