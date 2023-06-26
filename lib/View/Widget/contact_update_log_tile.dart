import 'package:flutter/material.dart';
import 'package:new_contact_bloc/Data/Model/contact_model_hive.dart';

class ContactUpdateLoagTile extends StatelessWidget {
  final ContactModelHive contact;

  const ContactUpdateLoagTile({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Text("Name: ${contact.name}"),
            Text("Email: ${contact.email}"),
            Text("Phone Number: ${contact.phoneNumber}"),
            Text("isFavourite: ${(contact.isFavourite == 1) ? true : false}"),
            Text("Updated Time: ${contact.updatedTime}"),
          ]),
        ),
      ),
    );
  }
}
