import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_contact_bloc/Data/DataProvider/contact_provider.dart';

import '../../Data/Model/contact_model.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final _contactDB = ContactsDatabase.instance;

  ContactBloc() : super(ContactInitial()) {
    on<AllButtonTappedEvent>(allButtonTappedEvent);

    on<FavButtonTappedEvent>(favButtonTappedEvent);

    on<AddFloatingButtonTappedEvent>(addFloatingButtonTappedEvent);

    on<CancelButtonTappedEvent>(cancelButtonTappedEvent);

    on<AddButtonTappedEvent>(addButtonTappedEvent);

    on<ContactListTileTapped>(contactListTileTapped);

    on<UpdateButtonTappedEvent>(updateButtonTappedEvent);

    on<DeleteButtonTappedEvent>(deleteButtonTappedEvent);
  }

  //! Load all contacts
  FutureOr<void> allButtonTappedEvent(
      AllButtonTappedEvent event, Emitter<ContactState> emit) async {
    emit(ContactsLoadingState());
    try {
      List<Contact> allContacts = await _contactDB.readAllContacts();
      emit(ContactLoadSuccessState(contacts: allContacts));
    } catch (e) {
      emit(ContactErrorState(error: e.toString()));
    }
  }

  //! Load favourite contacts
  FutureOr<void> favButtonTappedEvent(
      FavButtonTappedEvent event, Emitter<ContactState> emit) async {
    emit(ContactsLoadingState());
    try {
      List<Contact> allContacts = await _contactDB.readAllContacts();
      List<Contact> favContacts = allContacts
          .where(
            (contact) => contact.isFavourite == 1,
          )
          .toList();
      emit(ContactLoadSuccessState(contacts: favContacts));
    } catch (e) {
      emit(ContactErrorState(error: e.toString()));
    }
  }

  //! Tapped on add floating action button
  FutureOr<void> addFloatingButtonTappedEvent(
      AddFloatingButtonTappedEvent event, Emitter<ContactState> emit) {
    emit(ContactAddFloatButtonTappedState());
  }

  //// Create new contact
  //! cancel button tapped
  FutureOr<void> cancelButtonTappedEvent(
      CancelButtonTappedEvent event, Emitter<ContactState> emit) {
    emit(ContactCancelButtonTappedState());
  }

  //! add button tapped
  FutureOr<void> addButtonTappedEvent(
      AddButtonTappedEvent event, Emitter<ContactState> emit) async {
    emit(ContactAddingState());
    try {
      var contact = await _contactDB.create(event.contact);
      if (contact != null) {
        emit(ContactCancelButtonTappedState());
      } else {
        emit(ContactErrorState(error: "No able to fetch data"));
      }
    } catch (e) {
      emit(ContactErrorState(error: e.toString()));
    }
  }

  //! tap on the contact list tile
  FutureOr<void> contactListTileTapped(
      ContactListTileTapped event, Emitter<ContactState> emit) {
    emit(ContactDetailTappedState(contact: event.contact));
  }

  FutureOr<void> updateButtonTappedEvent(
      UpdateButtonTappedEvent event, Emitter<ContactState> emit) async {
    emit(ContactsLoadingState());
    try {
      var result = await _contactDB.update(event.contact);
      emit(ContactCancelButtonTappedState());
    } catch (e) {
      emit(ContactErrorState(error: e.toString()));
    }
  }

  FutureOr<void> deleteButtonTappedEvent(
      DeleteButtonTappedEvent event, Emitter<ContactState> emit) async {
    emit(ContactsLoadingState());
    try {
      var result = await _contactDB.delete(event.id);
      emit(ContactCancelButtonTappedState());
    } catch (e) {
      emit(ContactErrorState(error: e.toString()));
    }
  }
}
