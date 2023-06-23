// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contact_detail_bloc.dart';

@immutable
abstract class ContactDetailEvent {}

class CancelButtonTapped extends ContactDetailEvent {}

class AddButtonTapped extends ContactDetailEvent {
  final Contact contact;
  AddButtonTapped({
    required this.contact,
  });
}

class UpdateButtonTapped extends ContactDetailEvent {
  final Contact contact;
  UpdateButtonTapped({
    required this.contact,
  });
}

class DeleteButtonTapped extends ContactDetailEvent {
  final int id;
  DeleteButtonTapped({
    required this.id,
  });
}
