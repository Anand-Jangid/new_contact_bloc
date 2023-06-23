// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent {}

//! Buttons on the contact screen(Home page)
class AllButtonTappedEvent extends ContactEvent {}

class FavButtonTappedEvent extends ContactEvent {}

class ImageButtonTappedEvent extends ContactEvent{}

class AddFloatingButtonTappedEvent extends ContactEvent {}

//! Tapping on contact list tile
class ContactListTileTapped extends ContactEvent {
  final Contact contact;
  ContactListTileTapped({
    required this.contact,
  });
}
