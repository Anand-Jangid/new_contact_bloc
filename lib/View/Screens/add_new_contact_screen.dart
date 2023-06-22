// import 'package:contacts_bloc/Data/Model/contact_model.dart';
// import 'package:contacts_bloc/UI/Screens/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_contact_bloc/Data/Model/contact_model.dart';
import 'package:new_contact_bloc/View/Screens/contact_screen.dart';

import '../../Logic/bloc/contact_bloc.dart';

// import '../../Logic/bloc/contact_bloc.dart';

class AddNewContactScreen extends StatefulWidget {
  final Contact? contact;
  const AddNewContactScreen({super.key, this.contact});

  @override
  State<AddNewContactScreen> createState() => _AddNewContactScreenState();
}

class _AddNewContactScreenState extends State<AddNewContactScreen> {
  late final _nameController;
  late final _emailController;
  late final _numberController;
  late int isFavourite;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact?.name);
    _emailController = TextEditingController(text: widget.contact?.email);
    _numberController =
        TextEditingController(text: widget.contact?.phoneNumber);
    isFavourite = widget.contact?.isFavourite ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Contact"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<ContactBloc, ContactState>(
        listenWhen: (previous, current) => current is ContactActionState,
        buildWhen: (previous, current) => current is! ContactActionState,
        listener: (context, state) {
          if (state is ContactCancelButtonTappedState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const ContactScreen()));
          }
          // else if (state is CancelAddingContactState) {
          //   Navigator.of(context).pop();
          // }
        },
        builder: (context, state) {
          if (state is ContactAddingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      child: Icon(
                        Icons.person,
                        size: 110,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          label: const Text('Name'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          label: const Text('Email'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: const Text('Phone Number'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CheckboxListTile(
                        title: const Text('Is Favourite'),
                        value: (isFavourite == 1) ? true : false,
                        onChanged: (bool? value) {
                          setState(() {
                            (value!) ? (isFavourite = 1) : (isFavourite = 0);
                          });
                        }),
                    (widget.contact == null)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Cancel button
                              ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<ContactBloc>(context)
                                        .add(CancelButtonTappedEvent());
                                  },
                                  child: const Text("Cancel")),
                              const SizedBox(
                                width: 20,
                              ),
                              // Add button
                              ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<ContactBloc>(context).add(
                                        AddButtonTappedEvent(
                                            contact: Contact(
                                                name: _nameController.text,
                                                email: _emailController.text,
                                                phoneNumber:
                                                    _numberController.text,
                                                isFavourite: isFavourite,
                                                createdTime: DateTime.now())));
                                  },
                                  child: const Text("ADD")),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Cancel button
                              ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<ContactBloc>(context)
                                        .add(CancelButtonTappedEvent());
                                  },
                                  child: const Text("Cancel")),
                              const SizedBox(
                                width: 20,
                              ),
                              // Update button
                              ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<ContactBloc>(context).add(UpdateButtonTappedEvent(contact: Contact(id: widget.contact!.id, name: _nameController.text, email: _emailController.text, phoneNumber: _numberController.text,isFavourite: isFavourite, createdTime: DateTime.now())));
                                  },
                                  child: const Text("Update")),
                              const SizedBox(
                                width: 20,
                              ),
                              // Delete button
                              ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<ContactBloc>(context).add(DeleteButtonTappedEvent(id: widget.contact!.id!));
                                  },
                                  child: const Text("Delete")),
                            ],
                          )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
  }
}
