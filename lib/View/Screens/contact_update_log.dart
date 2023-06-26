import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Logic/bloc/contact_update_log/contact_update_log_bloc.dart';
import '../Widget/contact_update_log_tile.dart';

class ContactUpdateLog extends StatefulWidget {
  final int id;
  const ContactUpdateLog({super.key, required this.id});

  @override
  State<ContactUpdateLog> createState() => _ContactUpdateLogState();
}

class _ContactUpdateLogState extends State<ContactUpdateLog> {
  @override
  void initState() {
    super.initState();
    context
        .read<ContactUpdateLogBloc>()
        .add(ContactUpdateLogLoad(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Log"),
      ),
      body: BlocBuilder<ContactUpdateLogBloc, ContactUpdateLogState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case ContactUpdateLogLoadedSuccessfully:
              final successState = state as ContactUpdateLogLoadedSuccessfully;
              return ContactUpdateLoagTile(contact: successState.contacts);
            case ContactUpdateLogLoadError:
              final errorState = state as ContactUpdateLogLoadError;
              return Center(child: Text(errorState.error));
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
