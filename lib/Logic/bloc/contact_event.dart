// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent {}

//! Buttons on the contact screen(Home page)
class AllButtonTappedEvent extends ContactEvent {}

class FavButtonTappedEvent extends ContactEvent {}

class AddFloatingButtonTappedEvent extends ContactEvent {}

//! Add Contact events
class CancelButtonTappedEvent extends ContactEvent {}

class AddButtonTappedEvent extends ContactEvent {
  final Contact contact;
  AddButtonTappedEvent({
    required this.contact,
  });
}

//! Tapping on update button
class UpdateButtonTappedEvent extends ContactEvent {
  final Contact contact;
  UpdateButtonTappedEvent({
    required this.contact,
  });
}

//! Tapping on delete button
class DeleteButtonTappedEvent extends ContactEvent {
  final int id;
  DeleteButtonTappedEvent({
    required this.id,
  });
}

//! Tapping on contact list tile
class ContactListTileTapped extends ContactEvent {
  final Contact contact;
  ContactListTileTapped({
    required this.contact,
  });
}
