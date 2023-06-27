// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'image_bloc.dart';

@immutable
abstract class ImageState {}

abstract class ImageActionState extends ImageState {}

class ImageInitial extends ImageState {

}

class ImageSuccessfullyAddedState extends ImageState {
  final List<ImageModel> image;
  ImageSuccessfullyAddedState({
    required this.image,
  });
}

class ImageAddErrorState extends ImageState {
  final String error;
  ImageAddErrorState({
    required this.error,
  });
}

class ImageLoadingState extends ImageState{}
