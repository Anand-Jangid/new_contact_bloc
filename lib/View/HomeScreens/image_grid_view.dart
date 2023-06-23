import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Logic/bloc/contact/contact_bloc.dart';

class ImageGridView extends StatefulWidget {
  const ImageGridView({super.key});

  @override
  State<ImageGridView> createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Images"),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            "Image",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            return BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.collections), label: 'All'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favourite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.image), label: 'Images'),
              ],
              currentIndex: 2,
              onTap: (int index) {
                if (index == 0) {
                  context.read<ContactBloc>().add(AllButtonTappedEvent());
                } else if (index == 1) {
                  context.read<ContactBloc>().add(FavButtonTappedEvent());
                }else if(index == 2){
                  context.read<ContactBloc>().add(ImageButtonTappedEvent());
                }
              },
              backgroundColor: Colors.blueAccent[100],
            );
          },
        ));
  }
}
