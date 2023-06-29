import 'package:flutter/material.dart';
import '../../Data/Model/contact_model.dart';
import 'contact_list.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Contact> contacts;

  CustomSearchDelegate({
    required this.contacts,
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Contact> matchQuery = [];
    for (var contact in contacts) {
      if (contact.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(contact);
      }
    }
    return ContactList(contacts: matchQuery);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Contact> matchQuery = [];
    for (var contact in contacts) {
      if (contact.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(contact);
      }
    }
    return ContactList(contacts: matchQuery);
  }
}
