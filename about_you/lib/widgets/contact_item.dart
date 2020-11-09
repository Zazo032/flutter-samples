import 'package:about_you/routes/contact_details/contact_details_route.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({@required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.yellow,
        child: Hero(
          tag: 'logo_${name.hashCode}',
          child: const FlutterLogo(),
        ),
      ),
      title: Hero(
        tag: name.hashCode,
        child: Material(
          color: Colors.transparent,
          child: Text(name),
        ),
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.phone,
          color: Colors.black,
        ),
        onPressed: () => null,
      ),
      onTap: () {
        return Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) {
              return ContactDetails(name: name);
            },
          ),
        );
      },
    );
  }
}
