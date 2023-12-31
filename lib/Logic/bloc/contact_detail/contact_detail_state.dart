// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contact_detail_bloc.dart';

@immutable
abstract class ContactDetailState {}

abstract class ContactDetailActionState extends ContactDetailState {}

class ContactDetailInitial extends ContactDetailState {}

//when adding is completed or cancel button is tapped
class MoveToBackPage extends ContactDetailActionState {}

//when adding new contact is in process
class ContactProcessingState extends ContactDetailState {}

//when there is error in doing some action
class ContactErrorState extends ContactDetailState {
  final String error;
  ContactErrorState({required this.error});
}

class ShowModelBottomSheetOfPhoto extends ContactDetailActionState {}

//Load image while adding data
class ImageLoadedState extends ContactDetailState {
  final List<String>? imageString;
  ImageLoadedState({
    this.imageString,
  });
}

class ShowBigImageState extends ContactDetailActionState {
  final String imageString;
  ShowBigImageState({
    required this.imageString,
  });
}

//Load images of previously created record
class AllImagesLoadedState extends ContactDetailState {
  final List<String> images;
  AllImagesLoadedState({
    required this.images,
  });
}

//No image found in previously created record
class NoImageFoundState extends ContactDetailState {}

class FullScreenImageState extends ContactDetailActionState {
  final List<String> images;
  FullScreenImageState({
    required this.images,
  });
}
