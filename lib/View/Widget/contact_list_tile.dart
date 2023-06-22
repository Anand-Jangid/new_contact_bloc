import 'package:flutter/material.dart';
import '../../Data/Model/contact_model.dart';

class ContactListTile extends StatelessWidget {
  final Contact contact;
  const ContactListTile({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(contact.name),
        subtitle: Text(contact.phoneNumber),
        trailing: (contact.isFavourite == 1) 
        ? const Icon(Icons.favorite) 
        : const Icon(Icons.favorite_border),
        
      ),
    );
  }
}