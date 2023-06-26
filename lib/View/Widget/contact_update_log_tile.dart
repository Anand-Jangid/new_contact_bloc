import 'package:flutter/material.dart';
import 'package:new_contact_bloc/Data/Model/contact_model_hive.dart';

class ContactUpdateLoagTile extends StatelessWidget {
  final ContactModelHive contact;

  const ContactUpdateLoagTile({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contact.name.length,
      itemBuilder: (context, index) {
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
                Text("Name: ${contact.name[index]}"),
                Text("Email: ${contact.email[index]}"),
                Text("Phone Number: ${contact.phoneNumber[index]}"),
                Text(
                    "isFavourite: ${(contact.isFavourite[index] == 1) ? true : false}"),
                Text("Updated Time: ${contact.updatedTime[index]}"),
              ]),
            ),
          ),
        );
      },
    );
  }
}
