import 'package:flutter/material.dart';
import 'package:new_contact_bloc/Data/Model/contact_model_hive.dart';

class ContactUpdateLoagTile extends StatelessWidget {
  final ContactModelHive contactModelHive;

  const ContactUpdateLoagTile({super.key, required this.contactModelHive});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [
        Text("Name: ${contactModelHive.name}"),
        Text("Email: ${contactModelHive.email}"),
        Text("Phone Number: ${contactModelHive.phoneNumber}"),
        Text("isFavourite: ${contactModelHive.isFavourite}"),
        Text("Updated Time: ${contactModelHive.updatedTime}"),
      ]),
    );
  }
}
