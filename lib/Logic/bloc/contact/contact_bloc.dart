import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_contact_bloc/Data/DataProvider/contact_provider.dart';

import '../../../Data/Model/contact_model.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  // final contactsDatabase = ContactsDatabase.instance;

  final ContactsDatabase contactsDatabase;

  ContactBloc({required this.contactsDatabase}) : super(ContactInitial()) {
    on<AllButtonTappedEvent>(allButtonTappedEvent);

    on<FavButtonTappedEvent>(favButtonTappedEvent);

    on<AddFloatingButtonTappedEvent>(addFloatingButtonTappedEvent);

    on<ContactListTileTapped>(contactListTileTapped);

    on<ImageButtonTappedEvent>(imageButtonTappedEvent);

    on<ExitingApp>(exitingApp);
  }

  //! Load all contacts
  FutureOr<void> allButtonTappedEvent(
      AllButtonTappedEvent event, Emitter<ContactState> emit) async {
    emit(ContactsLoadingState());
    try {
      List<Contact> allContacts = await contactsDatabase.readAllContacts();
      emit(ContactLoadSuccessState(
          contacts: allContacts, bottomNavigatorLocation: 0));
    } catch (e) {
      emit(ContactErrorState(error: e.toString()));
    }
  }

  //! Load favourite contacts
  FutureOr<void> favButtonTappedEvent(
      FavButtonTappedEvent event, Emitter<ContactState> emit) async {
    emit(ContactsLoadingState());
    try {
      List<Contact> allContacts = await contactsDatabase.readAllContacts();
      List<Contact> favContacts = allContacts
          .where(
            (contact) => contact.isFavourite == 1,
          )
          .toList();
      emit(ContactLoadSuccessState(
          contacts: favContacts, bottomNavigatorLocation: 1));
    } catch (e) {
      emit(ContactErrorState(error: e.toString()));
    }
  }

  //! Tapped on add floating action button
  FutureOr<void> addFloatingButtonTappedEvent(
      AddFloatingButtonTappedEvent event, Emitter<ContactState> emit) {
    emit(ContactAddFloatButtonTappedState());
  }

  //! tap on the contact list tile
  FutureOr<void> contactListTileTapped(
      ContactListTileTapped event, Emitter<ContactState> emit) {
    emit(ContactDetailTappedState(contact: event.contact));
  }

  FutureOr<void> imageButtonTappedEvent(
      ImageButtonTappedEvent event, Emitter<ContactState> emit) {
    emit(ImageTappedState());
  }

  FutureOr<void> exitingApp(ExitingApp event, Emitter<ContactState> emit) async{
    await contactsDatabase.close();
  }
}
