import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../Data/DataProvider/contact_provider.dart';
import '../../../../Data/Model/contact_model_hive.dart';

part 'contact_update_log_event.dart';
part 'contact_update_log_state.dart';

class ContactUpdateLogBloc
    extends Bloc<ContactUpdateLogEvent, ContactUpdateLogState> {
  final ContactsDatabase contactsDatabase;

  ContactUpdateLogBloc({required this.contactsDatabase})
      : super(ContactUpdateLogInitial()) {
    on<ContactUpdateLogLoad>(contactUpdateLogLoad);
  }

  FutureOr<void> contactUpdateLogLoad(
      ContactUpdateLogLoad event, Emitter<ContactUpdateLogState> emit) {
    emit(ContactUpdateLogLoading());
    try {
      var contactUpdateLog = contactsDatabase.getContactUpdateLog(event.id);
      emit(ContactUpdateLogLoadedSuccessfully(
          contactUpdateLogs: [contactUpdateLog]));
    } catch (e) {
      emit(ContactUpdateLogLoadError(error: e.toString()));
    }
  }
}
