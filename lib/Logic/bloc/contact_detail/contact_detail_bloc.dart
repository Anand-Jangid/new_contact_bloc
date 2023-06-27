import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:new_contact_bloc/Data/DataProvider/image_provider.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../Data/DataProvider/contact_provider.dart';
import '../../../../Data/Model/contact_model.dart';
import 'package:path/path.dart';

import '../../../Data/Model/image_model.dart';
part 'contact_detail_event.dart';
part 'contact_detail_state.dart';

class ContactDetailBloc extends Bloc<ContactDetailEvent, ContactDetailState> {
  final ContactsDatabase contactsDatabase;
  final ImageDatabase imageDatabase;

  ContactDetailBloc(
      {required this.contactsDatabase, required this.imageDatabase})
      : super(ContactDetailInitial()) {
    on<CancelButtonTapped>(cancelButtonTapped);

    on<AddButtonTapped>(addButtonTapped);

    on<UpdateButtonTapped>(updateButtonTapped);

    on<DeleteButtonTapped>(deleteButtonTapped);

    on<ImageIconTapped>(imageIconTapped);

    on<CameraImageSelected>(cameraImageSelected);

    on<GalarayImageSelected>(galarayImageSelected);
  }

  FutureOr<void> cancelButtonTapped(
      CancelButtonTapped event, Emitter<ContactDetailState> emit) {
    emit(MoveToBackPage());
  }

  FutureOr<void> addButtonTapped(
      AddButtonTapped event, Emitter<ContactDetailState> emit) async {
    emit(ContactProcessingState());
    try {
      var contact = await contactsDatabase.create(event.contact);
      //TODO: check the contact is created successfully
      emit(MoveToBackPage());
    } catch (e) {
      emit(ContactErrorState(error: e.toString()));
    }
  }

  FutureOr<void> updateButtonTapped(
      UpdateButtonTapped event, Emitter<ContactDetailState> emit) async {
    emit(ContactProcessingState());
    try {
      var result = await contactsDatabase.update(event.contact);
      emit(MoveToBackPage());
    } catch (e) {
      emit(ContactErrorState(error: e.toString()));
    }
  }

  FutureOr<void> deleteButtonTapped(
      DeleteButtonTapped event, Emitter<ContactDetailState> emit) async {
    emit(ContactProcessingState());
    try {
      var result = await contactsDatabase.delete(event.id);
      //TODO check if the data is deleted successfully
      emit(MoveToBackPage());
    } catch (e) {
      emit(ContactErrorState(error: e.toString()));
    }
  }

  FutureOr<void> imageIconTapped(
      ImageIconTapped event, Emitter<ContactDetailState> emit) {
    emit(ShowModelBottomSheetOfPhoto());
  }

  FutureOr<void> cameraImageSelected(
      CameraImageSelected event, Emitter<ContactDetailState> emit) async {
    try {
      final String? imageString =
          await imageDatabase.getImageString(ImageSource.camera);
      if(imageString != null){
        contactsDatabase.update(Contact(
            id: event.contact.id,
            name: event.contact.name,
            email: event.contact.email,
            phoneNumber: event.contact.phoneNumber,
            isFavourite: event.contact.isFavourite,
            createdTime: event.contact.createdTime,
            updatedTime: event.contact.updatedTime,
            imageString: imageString));
        
        emit(MoveToBackPage());
      }
    } catch (e) {
      emit(ContactErrorState(error: e.toString()));
    }
  }

  FutureOr<void> galarayImageSelected(
      GalarayImageSelected event, Emitter<ContactDetailState> emit) async {
    try {
      final String? imageString =
          await imageDatabase.getImageString(ImageSource.gallery);
      if(imageString != null){
        contactsDatabase.update(Contact(
            id: event.contact.id,
            name: event.contact.name,
            email: event.contact.email,
            phoneNumber: event.contact.phoneNumber,
            isFavourite: event.contact.isFavourite,
            createdTime: event.contact.createdTime,
            updatedTime: event.contact.updatedTime,
            imageString: imageString));
        
        emit(MoveToBackPage());
      }
    } catch (e) {
      emit(ContactErrorState(error: e.toString()));
    }
  }
}
