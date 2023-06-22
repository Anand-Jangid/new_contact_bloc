// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contact_bloc.dart';

@immutable
abstract class ContactState {}

abstract class ContactActionState extends ContactState {}

class ContactInitial extends ContactState {}

//! contacts load states

class ContactsLoadingState extends ContactState {
  //// return CitcularProgressIndicator();
}

class ContactErrorState extends ContactState {
  final String error;
  ContactErrorState({
    required this.error,
  });
}

class ContactLoadSuccessState extends ContactState {
  final List<Contact> contacts;
  ContactLoadSuccessState({
    required this.contacts,
  });
}

//! add contact states

class ContactAddFloatButtonTappedState extends ContactActionState {}

class ContactCancelButtonTappedState extends ContactActionState {}

class ContactAddingState extends ContactState {}

//! Contact detail tapped state
class ContactDetailTappedState extends ContactActionState {
  final Contact contact;
  ContactDetailTappedState({
    required this.contact,
  });
}
