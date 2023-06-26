import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../Data/DataProvider/contact_provider.dart';
import '../../../../Data/Model/contact_model.dart';

part 'contact_detail_event.dart';
part 'contact_detail_state.dart';

class ContactDetailBloc extends Bloc<ContactDetailEvent, ContactDetailState> {
  final ContactsDatabase contactsDatabase;

  ContactDetailBloc({required this.contactsDatabase})
      : super(ContactDetailInitial()) {
    on<CancelButtonTapped>(cancelButtonTapped);

    on<AddButtonTapped>(addButtonTapped);

    on<UpdateButtonTapped>(updateButtonTapped);

    on<DeleteButtonTapped>(deleteButtonTapped);
  }

  FutureOr<void> cancelButtonTapped(
      CancelButtonTapped event, Emitter<ContactDetailState> emit) {
    emit(MoveToBackPage());
  }

  FutureOr<void> addButtonTapped(
      AddButtonTapped event, Emitter<ContactDetailState> emit) async {
    emit(ContactProcessingState());
    try {
      print(event.contact.updatedTime);
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
      print("moving to back screen");
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
}
