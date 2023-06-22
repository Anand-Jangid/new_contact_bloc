// import 'package:contacts_bloc/UI/Screens/contact_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../Data/Model/contact_model.dart';
// import '../../Logic/bloc/contact_bloc.dart';

// class ContactDetailScreen extends StatefulWidget {
//   final int index;
//   const ContactDetailScreen({super.key, required this.index});

//   @override
//   State<ContactDetailScreen> createState() => _ContactDetailScreenState();
// }

// class _ContactDetailScreenState extends State<ContactDetailScreen> {
//   late final TextEditingController _nameController;
//   late final TextEditingController _emailController;
//   late final TextEditingController _numberController;
//   late bool? isFavourite = false;

//   @override
//   void initState() {
//     Map<String, dynamic> contact = contacts[widget.index];
//     _nameController = TextEditingController(text: contact['name']);
//     _emailController = TextEditingController(text: contact['email']);
//     _numberController = TextEditingController(text: contact['phoneNumber']);
//     isFavourite = contact['isFavourite'];
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Contact Detail"),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//       ),
//       body: BlocConsumer<ContactBloc, ContactState>(
//         listenWhen: (previous, current) => current is ContactActionState,
//         buildWhen: (previous, current) => current is! ContactActionState,
//         listener: (context, state) {
//           if (state is ContactDetailCancelState ||
//               state is ContactDetailUpdateState ||
//               state is ContactDetailDeleteState) {
//             Navigator.of(context).pushReplacement(MaterialPageRoute(
//               builder: (context) => ContactScreen(),
//             ));
//             // Navigator.of(context).pop();
//           }
//         },
//         builder: (context, state) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const CircleAvatar(
//                     radius: 60,
//                     child: Icon(
//                       Icons.person,
//                       size: 110,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 40,
//                   ),
//                   TextFormField(
//                     controller: _nameController,
//                     keyboardType: TextInputType.name,
//                     decoration: InputDecoration(
//                         label: const Text('Name'),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15))),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   TextFormField(
//                     controller: _emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                         label: const Text('Email'),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15))),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   TextFormField(
//                     controller: _numberController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                         label: const Text('Phone Number'),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15))),
//                   ),
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   CheckboxListTile(
//                       title: const Text('Is Favourite'),
//                       value: isFavourite,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           isFavourite = value;
//                         });
//                       }),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ElevatedButton(
//                           onPressed: () {
//                             BlocProvider.of<ContactBloc>(context)
//                                 .add(ContactDetailCancelEvent());
//                           },
//                           child: const Text("Cancel")),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       ElevatedButton(
//                           onPressed: () {
//                             BlocProvider.of<ContactBloc>(context)
//                                 .add(ContactDetailUpdateEvent(
//                                     index: widget.index,
//                                     contact: Contact(
//                                       name: _nameController.text,
//                                       email: _emailController.text,
//                                       phoneNumber: _numberController.text,
//                                     )));
//                           },
//                           child: const Text("Update")),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       ElevatedButton(
//                           onPressed: () {
//                             BlocProvider.of<ContactBloc>(context).add(
//                                 ContactDetailDeleteEvent(index: widget.index));
//                           },
//                           child: const Text("Delete")),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _nameController.dispose();
//     _emailController.dispose();
//     _numberController.dispose();
//   }
// }
