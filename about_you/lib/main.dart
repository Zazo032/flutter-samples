import 'package:about_you/routes/contacts_list/contacts_list_route.dart';
import 'package:flutter/material.dart';

void main() => runApp(ContactsApp());

class ContactsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
      ),
      title: 'Flutter Demo',
      home: const ContactsList(
        header: Padding(
          padding: EdgeInsets.all(16.0),
          child: FlutterLogo(
            style: FlutterLogoStyle.horizontal,
            size: 32.0,
          ),
        ),
        footer: Padding(
          padding: EdgeInsets.all(16.0),
          child: FlutterLogo(
            style: FlutterLogoStyle.horizontal,
            size: 32.0,
          ),
        ),
      ),
    );
  }
}
