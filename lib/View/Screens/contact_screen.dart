import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_contact_bloc/View/HomeScreens/contact_list_page.dart';
import 'package:new_contact_bloc/View/Screens/add_new_contact_screen.dart';
import 'package:new_contact_bloc/View/HomeScreens/image_grid_view.dart';
import '../../Logic/bloc/contact/contact_bloc.dart';

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
    return BlocConsumer<ContactBloc, ContactState>(
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
            final contactLoadedState = state as ContactLoadSuccessState;
            return ContactListPage(
                bottmNavLocation: contactLoadedState.bottomNavigatorLocation,
                contacts: contactLoadedState.contacts);
          case ImageTappedState:
            return ImageGridView();
          case ContactErrorState:
            final contactErrorState = state as ContactErrorState;
            return Scaffold(
                appBar: AppBar(
                  title: const Text("My Contacts"),
                  centerTitle: true,
                ),
                body: Center(
                  child: Text(
                    contactErrorState.error,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.collections), label: 'All'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite), label: 'Favourite'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.image), label: 'Images'),
                  ],
                  currentIndex: 0,
                  onTap: (int index) {
                    if (index == 0) {
                      // BlocProvider.of<ContactBloc>(context).add(AllButtonTappedEvent());
                      context.read<ContactBloc>().add(AllButtonTappedEvent());
                    } else if (index == 1) {
                      // BlocProvider.of<ContactBloc>(context).add(FavButtonTappedEvent());
                      context.read<ContactBloc>().add(FavButtonTappedEvent());
                    }
                  },
                  backgroundColor: Colors.blueAccent[100],
                ));
          default:
            return Scaffold(
                appBar: AppBar(
                  title: const Text("My Contacts"),
                  centerTitle: true,
                ),
                body: const Center(child: CircularProgressIndicator()),
                bottomNavigationBar: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.collections), label: 'All'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite), label: 'Favourite'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.image), label: 'Images'),
                  ],
                  currentIndex: 0,
                  onTap: (int index) {
                    if (index == 0) {
                      // BlocProvider.of<ContactBloc>(context).add(AllButtonTappedEvent());
                      context.read<ContactBloc>().add(AllButtonTappedEvent());
                    } else if (index == 1) {
                      // BlocProvider.of<ContactBloc>(context).add(FavButtonTappedEvent());
                      context.read<ContactBloc>().add(FavButtonTappedEvent());
                    }
                  },
                  backgroundColor: Colors.blueAccent[100],
                ));
        }
      },
    );
  }
}
