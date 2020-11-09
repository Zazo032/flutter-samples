import 'package:about_you/data/contacts.dart';
import 'package:about_you/widgets/contact_item.dart';
import 'package:about_you/widgets/grouped_list_view.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({
    this.header,
    this.footer,
  });

  final Widget header;
  final Widget footer;

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> with TickerProviderStateMixin<ContactsList> {
  List<String> _contacts;
  FocusNode _searchFocus;
  ScrollController _scrollController;
  TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _contacts = kContacts.toList();
    _contacts
      ..sort((String a, String b) => a.toLowerCase().compareTo(b.toLowerCase()));
    _searchFocus = FocusNode();
    _searchFocus.addListener(() => setState(() {}));
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (MediaQuery.of(context).viewInsets.bottom == 0.0)
        _searchFocus.unfocus();
    });
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchFocus.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<String> _searchContacts(String query) {
    return kContacts
        .where((String _contact) =>
            _contact.toLowerCase().startsWith(query.toLowerCase()) ||
            _contact.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_searchFocus.hasFocus) {
          _searchFocus.unfocus();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (_) => _searchFocus.unfocus(),
          child: CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 140.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: SafeArea(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          focusNode: _searchFocus,
                          keyboardType: TextInputType.name,
                          controller: _searchController,
                          textInputAction: TextInputAction.search,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                style: BorderStyle.solid,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                style: BorderStyle.solid,
                                width: 2.0,
                              ),
                            ),
                            hintStyle: TextStyle(color: Colors.white60),
                            hintText: 'Who you gonna call?',
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'Search contact',
                            prefixIcon: Icon(Icons.search, color: Colors.white),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _contacts = _searchContacts(value);
                              _contacts
                                ..sort((String a, String b) =>
                                    a.toLowerCase().compareTo(b.toLowerCase()));
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                floating: true,
                pinned: true,
                stretch: true,
                title: const Text('Contacts list'),
              ),
              SliverToBoxAdapter(
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  vsync: this,
                  child: !_searchFocus.hasFocus && widget.header != null
                      ? widget.header
                      : const SizedBox(),
                ),
              ),
              GroupedListView(
                data: _contacts,
                builder: (BuildContext context, int index) {
                  final String _initialChar = _contacts[index].isNotEmpty
                      ? _contacts[index].substring(0, 1).toUpperCase()
                      : '';
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (_shouldShowHeader(index, _initialChar))
                        Container(
                          color: Colors.black,
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Text(
                                _initialChar,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ContactItem(name: _contacts[index]),
                    ],
                  );
                },
              ),
              SliverToBoxAdapter(
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  vsync: this,
                  child: !_searchFocus.hasFocus && widget.footer != null
                      ? widget.footer
                      : const SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _shouldShowHeader(int index, String char) {
    if (index == 0) {
      return true;
    } else if (_contacts[index].toUpperCase().startsWith(char) &&
        !_contacts[index - 1].toUpperCase().startsWith(char)) {
      return true;
    }
    return false;
  }
}
