import 'package:flutter/material.dart';
import 'package:new_contact_bloc/Data/DataProvider/contact_provider.dart';
import 'package:new_contact_bloc/Logic/bloc/contact_detail/contact_detail_bloc.dart';
import 'Logic/bloc/contact/contact_bloc.dart';
import 'View/Screens/contact_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  
  ///Instance of contactdatabase
  final ContactsDatabase contactsDatabase = ContactsDatabase.instance;
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContactBloc>(create: (context) => ContactBloc(contactsDatabase: contactsDatabase)),
        BlocProvider<ContactDetailBloc>(create: (context) => ContactDetailBloc(contactsDatabase: contactsDatabase)),
      ],
      child: const MaterialApp(
          home: ContactScreen(),
        ),
    );
    
  }
}