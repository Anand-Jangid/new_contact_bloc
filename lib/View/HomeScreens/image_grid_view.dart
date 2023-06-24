import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';
import '../../Logic/bloc/contact/contact_bloc.dart';

class ImageGridView extends StatefulWidget {
  const ImageGridView({super.key});

  @override
  State<ImageGridView> createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  final ImagePicker _picker = ImagePicker();

  List<XFile>? _mediaFileList;

  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;

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
          onPressed: () async {
            await _onImageButtonPressed(ImageSource.camera, context: context);
            print(_mediaFileList);
          },
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
                } else if (index == 2) {
                  context.read<ContactBloc>().add(ImageButtonTappedEvent());
                }
              },
              backgroundColor: Colors.blueAccent[100],
            );
          },
        ));
  }

  Future<void> _onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
    bool isMultiImage = false,
    bool isMedia = false,
  }) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );
      setState(() {
        _setImageFileListFromFile(pickedFile);
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  // Future<void> _displayPickImageDialog(
  //     BuildContext context, OnPickImageCallback onPick) async {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Add optional parameters'),
  //           content: Column(
  //             children: <Widget>[
  //               TextField(
  //                 controller: maxWidthController,
  //                 keyboardType:
  //                     const TextInputType.numberWithOptions(decimal: true),
  //                 decoration: const InputDecoration(
  //                     hintText: 'Enter maxWidth if desired'),
  //               ),
  //               TextField(
  //                 controller: maxHeightController,
  //                 keyboardType:
  //                     const TextInputType.numberWithOptions(decimal: true),
  //                 decoration: const InputDecoration(
  //                     hintText: 'Enter maxHeight if desired'),
  //               ),
  //               TextField(
  //                 controller: qualityController,
  //                 keyboardType: TextInputType.number,
  //                 decoration: const InputDecoration(
  //                     hintText: 'Enter quality if desired'),
  //               ),
  //             ],
  //           ),
  //           actions: <Widget>[
  //             TextButton(
  //               child: const Text('CANCEL'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //             TextButton(
  //                 child: const Text('PICK'),
  //                 onPressed: () {
  //                   final double? width = maxWidthController.text.isNotEmpty
  //                       ? double.parse(maxWidthController.text)
  //                       : null;
  //                   final double? height = maxHeightController.text.isNotEmpty
  //                       ? double.parse(maxHeightController.text)
  //                       : null;
  //                   final int? quality = qualityController.text.isNotEmpty
  //                       ? int.parse(qualityController.text)
  //                       : null;
  //                   onPick(width, height, quality);
  //                   Navigator.of(context).pop();
  //                 }),
  //           ],
  //         );
  //       });
  // }
}
