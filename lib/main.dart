import 'package:flutter/material.dart';
import 'Logic/bloc/contact_bloc.dart';
import 'View/Screens/contact_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactBloc>(
      create: (context) => ContactBloc(),
      child: const MaterialApp(
        home: ContactScreen(),
      ),
    );
  }
}
