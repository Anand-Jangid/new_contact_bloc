part of 'contact_detail_bloc.dart';

@immutable
abstract class ContactDetailState {}

abstract class ContactDetailActionState extends ContactDetailState {}

class ContactDetailInitial extends ContactDetailState {}

//when adding is completed or cancel button is tapped
class MoveToBackPage extends ContactDetailActionState {}

//when adding new contact is in process
class ContactProcessingState extends ContactDetailState {}

//when there is error in doing some action
class ContactErrorState extends ContactDetailState {
  final String error;
  ContactErrorState({
    required this.error
  });
}