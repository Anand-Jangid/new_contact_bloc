// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contact_detail_bloc.dart';

@immutable
abstract class ContactDetailEvent {}

class CancelButtonTapped extends ContactDetailEvent {}

class AddButtonTapped extends ContactDetailEvent {
  final Contact contact;
  final List<String>? images;
  AddButtonTapped({required this.contact, this.images});
}

class UpdateButtonTapped extends ContactDetailEvent {
  final Contact contact;
  final List<String>? images;
  UpdateButtonTapped({required this.contact, this.images});
}

class DeleteButtonTapped extends ContactDetailEvent {
  final int id;
  DeleteButtonTapped({
    required this.id,
  });
}

class ImageIconTapped extends ContactDetailEvent {}

class CameraImageSelected extends ContactDetailEvent {
  final Contact contact;
  CameraImageSelected({
    required this.contact,
  });
}

class GalarayImageSelected extends ContactDetailEvent {
  final Contact contact;
  GalarayImageSelected({
    required this.contact,
  });
}

class ImageLoadEvent extends ContactDetailEvent {
  final ImageSource imageSource;
  ImageLoadEvent({
    required this.imageSource,
  });
}

class ShowBigImageEvent extends ContactDetailEvent {
  final String imageString;
  ShowBigImageEvent({
    required this.imageString,
  });
}

class LoadAllImagesEvent extends ContactDetailEvent {
  final int id;
  LoadAllImagesEvent({
    required this.id,
  });
}

class FullScreenImagesEvent extends ContactDetailEvent {
  final List<String> images;
  FullScreenImagesEvent({
    required this.images,
  });
}
