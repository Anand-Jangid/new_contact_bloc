import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data/Model/contact_model.dart';
import '../../Logic/bloc/contact/contact_bloc.dart';
import '../Widget/contact_list.dart';

class ContactListPage extends StatefulWidget {
  final List<Contact> contacts;
  final int bottmNavLocation;
  const ContactListPage({super.key, required this.bottmNavLocation, required this.contacts});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: (widget.bottmNavLocation == 0)
              ? Text("All Contacts")
              : Text("Favourite Contacts"),
          centerTitle: true,
        ),
        body: ContactList(contacts: widget.contacts ?? []),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<ContactBloc>().add(AddFloatingButtonTappedEvent());
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.collections), label: 'All'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favourite'),
            BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Images'),
          ],
          currentIndex: widget.bottmNavLocation,
          onTap: (int index) {
            if (index == 0) {
              context.read<ContactBloc>().add(AllButtonTappedEvent());
            } else if (index == 1) {
              context.read<ContactBloc>().add(FavButtonTappedEvent());
            } else if (index == 2) {
              context.read<ContactBloc>().add(ImageButtonTappedEvent());
            }
          },
          backgroundColor: Colors.blueAccent[100],
        ));
  }
}
