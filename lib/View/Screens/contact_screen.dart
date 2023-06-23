import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_contact_bloc/View/Screens/add_new_contact_screen.dart';
import '../../Logic/bloc/contact/contact_bloc.dart';
import '../Widget/contact_list_tile.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContactBloc>(context).add(AllButtonTappedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Contacts"),
          centerTitle: true,
        ),
        body: BlocConsumer<ContactBloc, ContactState>(
          listenWhen: (previous, current) => current is ContactActionState,
          buildWhen: (previous, current) => current is! ContactActionState,
          listener: (context, state) {
            if (state is ContactAddFloatButtonTappedState) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const AddNewContactScreen()));
            } else if (state is ContactDetailTappedState) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => AddNewContactScreen(
                        contact: state.contact,
                      )));
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case ContactLoadSuccessState:
                final allContactsState = state as ContactLoadSuccessState;
                return ListView.builder(
                    itemCount: allContactsState.contacts.length,
                    itemBuilder: (context, index) {
                      if (allContactsState.contacts.isEmpty) {
                        return const Center(
                          child: Text('No Data'),
                        );
                      }
                      return InkWell(
                        onTap: () {
                          BlocProvider.of<ContactBloc>(context).add(
                              ContactListTileTapped(
                                  contact: allContactsState.contacts[index]));
                        },
                        child: ContactListTile(
                            contact: allContactsState.contacts[index]),
                      );
                    });
              case ContactErrorState:
                final contactErrorState = state as ContactErrorState;
                return Center(child: Text(contactErrorState.error));
              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            BlocProvider.of<ContactBloc>(context)
                .add(AddFloatingButtonTappedEvent());
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.collections), label: 'All'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favourite'),
          ],
          currentIndex: 0,
          onTap: (int index) {
            if (index == 0) {
              BlocProvider.of<ContactBloc>(context).add(AllButtonTappedEvent());
            } else if (index == 1) {
              BlocProvider.of<ContactBloc>(context).add(FavButtonTappedEvent());
            }
          },
          backgroundColor: Colors.blueAccent[100],
        ));
  }
}
