// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contact_update_log_bloc.dart';

@immutable
abstract class ContactUpdateLogState {}

abstract class ContactUpdateLogActionState extends ContactUpdateLogState {}

class ContactUpdateLogInitial extends ContactUpdateLogState {}

class ContactUpdateLogLoading extends ContactUpdateLogState {}

class ContactUpdateLogLoadedSuccessfully extends ContactUpdateLogState {
  final ContactModelHive contacts;
  ContactUpdateLogLoadedSuccessfully({
    required this.contacts,
  });
}

class ContactUpdateLogLoadError extends ContactUpdateLogState {
  final String error;
  ContactUpdateLogLoadError({
    required this.error,
  });
}
