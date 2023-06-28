import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:video_player/video_player.dart';
import '../../Logic/bloc/contact/contact_bloc.dart';

class ImageGridView extends StatefulWidget {
  const ImageGridView({super.key});

  @override
  State<ImageGridView> createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Image Saving Demo'),
        ),
        body: const Center(child: Text("Images")),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // context.read<ImageBloc>().add(CameraImageSelected());
          },
          tooltip: 'Pick Image',
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.collections), label: 'All'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favourite'),
            BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Images'),
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
}
