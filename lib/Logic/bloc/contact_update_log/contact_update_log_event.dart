// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contact_update_log_bloc.dart';

@immutable
abstract class ContactUpdateLogEvent {}

class ContactUpdateLogLoad extends ContactUpdateLogEvent {
  final int id;
  ContactUpdateLogLoad({
    required this.id,
  });
}
