import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:new_contact_bloc/Data/DataProvider/image_provider.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../Data/Model/image_model.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageDatabase imageDatabase;

  ImageBloc({required this.imageDatabase}) : super(ImageInitial()) {
    on<CameraImageSelected>(cameraImageSelected);

    on<GalarayImageSelected>(galarayImageSelected);

    on<FetchInitialDataEvent>(fetchInitialDataEvent);
  }

  FutureOr<void> cameraImageSelected(
      CameraImageSelected event, Emitter<ImageState> emit) async {
    try {
      final File? pickedImage =
          await imageDatabase.pickImage(ImageSource.camera);

      if (pickedImage != null) {
        final String fileName = basename(pickedImage.path);
        final Directory appDir = await getApplicationDocumentsDirectory();
        final String imagePath = '${appDir.path}/$fileName';

        await pickedImage.copy(imagePath);

        final ImageModel imageModel = ImageModel(imagePath: imagePath);
        await imageDatabase.insertImage(imageModel);

        var images = await imageDatabase.getImages();
        emit(ImageSuccessfullyAddedState(image: images));
      }
    } catch (e) {
      emit(ImageAddErrorState(error: e.toString()));
    }
  }

  FutureOr<void> galarayImageSelected(
      GalarayImageSelected event, Emitter<ImageState> emit) async {
    try {
      final File? pickedImage =
          await imageDatabase.pickImage(ImageSource.camera);

      if (pickedImage != null) {
        final String fileName = basename(pickedImage.path);
        final Directory appDir = await getApplicationDocumentsDirectory();
        final String imagePath = '${appDir.path}/$fileName';

        await pickedImage.copy(imagePath);

        final ImageModel imageModel = ImageModel(imagePath: imagePath);
        var id = await imageDatabase.insertImage(imageModel);
        print('--------------id: ${id}------------');

        var images = await imageDatabase.getImages();
        emit(ImageSuccessfullyAddedState(image: images));
      }
    } catch (e) {
      emit(ImageAddErrorState(error: e.toString()));
    }
  }

  FutureOr<void> fetchInitialDataEvent(
      FetchInitialDataEvent event, Emitter<ImageState> emit) async {
    emit(ImageLoadingState());
    try {
      var images = await imageDatabase.getImages();
      emit(ImageSuccessfullyAddedState(image: images));
    } catch (e) {
      emit(ImageAddErrorState(error: e.toString()));
    }
  }
}
