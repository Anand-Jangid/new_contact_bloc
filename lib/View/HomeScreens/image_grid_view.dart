import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_contact_bloc/Logic/bloc/image/bloc/image_bloc.dart';
// import 'package:video_player/video_player.dart';
import '../../Logic/bloc/contact/contact_bloc.dart';
import '../../Logic/bloc/contact_detail/contact_detail_bloc.dart';

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
    context.read<ImageBloc>().add(FetchInitialDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Image Saving Demo'),
        ),
        body: BlocBuilder<ImageBloc, ImageState>(
          builder: (context, state) {
            if (state is ImageSuccessfullyAddedState) {
              return ListView.builder(
                itemCount: state.image.length,
                itemBuilder: (ctx, index) {
                  final image = state.image[index];
                  return ListTile(
                    leading: Image.file(
                      File(image.imagePath),
                      width: 50,
                      height: 50,
                    ),
                    title: Text(image.imagePath),
                  );
                },
              );
            } else if (state is ImageLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ImageAddErrorState) {
              return Center(child: Text(state.error));
            }
            return const Text("NO DATA");
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<ImageBloc>().add(CameraImageSelected());
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
