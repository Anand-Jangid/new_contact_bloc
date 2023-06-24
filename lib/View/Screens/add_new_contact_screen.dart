import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_contact_bloc/Data/Model/contact_model.dart';
import 'package:new_contact_bloc/View/Screens/contact_screen.dart';
import 'package:new_contact_bloc/View/Screens/contact_update_log.dart';
import '../../Logic/bloc/contact_detail/contact_detail_bloc.dart';

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
        title: (widget.contact == null)
            ? const Text("Create New Contact")
            : const Text("Edit Contact"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<ContactDetailBloc, ContactDetailState>(
        listenWhen: (previous, current) => current is ContactDetailActionState,
        buildWhen: (previous, current) => current is! ContactDetailActionState,
        listener: (context, state) {
          if (state is MoveToBackPage) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const ContactScreen()));
          }
        },
        builder: (context, state) {
          if (state is ContactProcessingState) {
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
                                    context
                                        .read<ContactDetailBloc>()
                                        .add(CancelButtonTapped());
                                  },
                                  child: const Text("Cancel")),
                              const SizedBox(
                                width: 20,
                              ),
                              // Add button
                              ElevatedButton(
                                  onPressed: () {
                                    context.read<ContactDetailBloc>().add(
                                        AddButtonTapped(
                                            contact: Contact(
                                                name: _nameController.text,
                                                email: _emailController.text,
                                                phoneNumber:
                                                    _numberController.text,
                                                isFavourite: isFavourite,
                                                createdTime: DateTime.now(),
                                                updatedTime: DateTime.now())));
                                  },
                                  child: const Text("ADD")),
                            ],
                          )
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  // Cancel button
                                  ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<ContactDetailBloc>()
                                            .add(CancelButtonTapped());
                                      },
                                      child: const Text("Cancel")),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  // Update button
                                  ElevatedButton(
                                      onPressed: () {
                                        context.read<ContactDetailBloc>().add(
                                            UpdateButtonTapped(
                                                contact: Contact(
                                                    id: widget.contact!.id,
                                                    name: _nameController.text,
                                                    email:
                                                        _emailController.text,
                                                    phoneNumber:
                                                        _numberController.text,
                                                    isFavourite: isFavourite,
                                                    createdTime: widget.contact
                                                            ?.createdTime ??
                                                        DateTime.now(),
                                                    updatedTime:
                                                        DateTime.now())));
                                      },
                                      child: const Text("Update")),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  // Delete button
                                  ElevatedButton(
                                      onPressed: () {
                                        context.read<ContactDetailBloc>().add(
                                            DeleteButtonTapped(
                                                id: widget.contact!.id!));
                                      },
                                      child: const Text("Delete")),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ContactUpdateLog(
                                                    id: widget.contact!.id!)));
                                  },
                                  child: const Text("Update Log")),
                              Text((widget.contact?.updatedTime ??
                                      DateTime.now())
                                  .toIso8601String()),
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
