import 'dart:io';
import 'package:flutter/material.dart';

class ImageViewScreen extends StatelessWidget {
  final List<String> images;
  const ImageViewScreen({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Image"),
      ),
      body: PageView.builder(
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Image.file(
              File(images[index]),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
            );
          }),
    );
  }
}
