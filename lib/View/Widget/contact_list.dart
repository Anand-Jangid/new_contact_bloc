import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Data/Model/contact_model.dart';
import '../../Logic/bloc/contact/contact_bloc.dart';
import 'contact_list_tile.dart';

class ContactList extends StatelessWidget {
  final List<Contact> contacts;
  const ContactList({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // BlocProvider.of<ContactBloc>(context)
              //     .add(ContactListTileTapped(contact: contacts[index]));
              context.read<ContactBloc>().add(
                  ContactListTileTapped(contact: contacts[index]));
            },
            child: ContactListTile(contact: contacts[index]),
          );
        });
  }
}
