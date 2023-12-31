// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contact_bloc.dart';

@immutable
abstract class ContactState {}

abstract class ContactActionState extends ContactState {}

class ContactInitial extends ContactState {}

//! contacts load states

class ContactsLoadingState extends ContactState {}

class ContactErrorState extends ContactState {
  final String error;
  ContactErrorState({
    required this.error,
  });
}

class ContactLoadSuccessState extends ContactState {
  final int bottomNavigatorLocation;
  final List<Contact> contacts;
  ContactLoadSuccessState({
    required this.contacts,
    required this.bottomNavigatorLocation,
  });
}

//! add contact states

class ContactAddFloatButtonTappedState extends ContactActionState {}

//! Contact detail tapped state
class ContactDetailTappedState extends ContactActionState {
  final Contact contact;
  ContactDetailTappedState({
    required this.contact,
  });
}

//! image states
class ImageTappedState extends ContactState{}