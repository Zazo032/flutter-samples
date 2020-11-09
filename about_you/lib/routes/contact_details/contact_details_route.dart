import 'package:flutter/material.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails({@required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact detail'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () => null,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'logo_${name.hashCode}',
              child: const FlutterLogo(size: 64.0),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Hero(
                tag: name.hashCode,
                child: Material(
                  color: Colors.transparent,
                  child: Text(name),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
