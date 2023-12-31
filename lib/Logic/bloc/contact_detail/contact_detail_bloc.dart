import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:new_contact_bloc/Data/DataProvider/image_provider.dart';
import '../../../../Data/DataProvider/contact_provider.dart';
import '../../../../Data/Model/contact_model.dart';
part 'contact_detail_event.dart';
part 'contact_detail_state.dart';

class ContactDetailBloc extends Bloc<ContactDetailEvent, ContactDetailState> {
  final ContactsDatabase contactsDatabase;
  final ImageDatabase imageDatabase;

  ContactDetailBloc(
      {required this.contactsDatabase, required this.imageDatabase})
      : super(ContactDetailInitial()) {
    on<CancelButtonTapped>(cancelButtonTapped);

    on<AddButtonTapped>(addButtonTapped);

    on<UpdateButtonTapped>(updateButtonTapped);

    on<DeleteButtonTapped>(deleteButtonTapped);

    on<ImageIconTapped>(imageIconTapped);

    on<CameraImageSelected>(cameraImageSelected);

    on<GalarayImageSelected>(galarayImageSelected);

    on<ImageLoadEvent>(imageLoadEvent);

    on<ShowBigImageEvent>(showBigImageEvent);

    on<LoadAllImagesEvent>(loadAllImagesEvent);

    on<FullScreenImagesEvent>(fullScreenImagesEvent);
  }

  FutureOr<void> cancelButtonTapped(
      CancelButtonTapped event, Emitter<ContactDetailState> emit) {
    emit(MoveToBackPage());
  }

  FutureOr<void> addButtonTapped(
      AddButtonTapped event, Emitter<ContactDetailState> emit) async {
    emit(ContactProcessingState());
    try {
      var contact = await contactsDatabase.create(event.contact, event.images);
      //TODO: check the contact is created successfully
      emit(MoveToBackPage());
    } catch (e) {
      emit(ContactErrorState(error: e.toString()));
    }
  }

  FutureOr<void> updateButtonTapped(
      UpdateButtonTapped event, Emitter<ContactDetailState> emit) async {
    emit(ContactProcessingState());
    try {
      var result = await contactsDatabase.update(event.contact, event.images);
      emit(MoveToBackPage());
    } catch (e) {
      emit(ContactErrorState(error: e.toString()));
    }
  }

  FutureOr<void> deleteButtonTapped(
      DeleteButtonTapped event, Emitter<ContactDetailState> emit) async {
    emit(ContactProcessingState());
    try {
      var result = await contactsDatabase.delete(event.id);
      //TODO check if the data is deleted successfully
      emit(MoveToBackPage());
    } catch (e) {
      emit(ContactErrorState(error: e.toString()));
    }
  }

  FutureOr<void> imageIconTapped(
      ImageIconTapped event, Emitter<ContactDetailState> emit) {
    emit(ShowModelBottomSheetOfPhoto());
  }

  FutureOr<void> cameraImageSelected(
      CameraImageSelected event, Emitter<ContactDetailState> emit) async {
    try {
      final List<String>? imagesList =
          await imageDatabase.getImageString(ImageSource.camera);
      if (imagesList != null) {
        contactsDatabase.update(
            Contact(
                id: event.contact.id,
                name: event.contact.name,
                email: event.contact.email,
                phoneNumber: event.contact.phoneNumber,
                isFavourite: event.contact.isFavourite,
                createdTime: event.contact.createdTime,
                updatedTime: event.contact.updatedTime),
            imagesList);

        emit(MoveToBackPage());
      }
    } catch (e) {
      emit(ContactErrorState(error: e.toString()));
    }
  }

  FutureOr<void> galarayImageSelected(
      GalarayImageSelected event, Emitter<ContactDetailState> emit) async {
    try {
      final List<String>? imagesList =
          await imageDatabase.getImageString(ImageSource.gallery);
      if (imagesList != null) {
        contactsDatabase.update(
            Contact(
              id: event.contact.id,
              name: event.contact.name,
              email: event.contact.email,
              phoneNumber: event.contact.phoneNumber,
              isFavourite: event.contact.isFavourite,
              createdTime: event.contact.createdTime,
              updatedTime: event.contact.updatedTime,
            ),
            imagesList);

        emit(MoveToBackPage());
      }
    } catch (e) {
      emit(ContactErrorState(error: e.toString()));
    }
  }

  FutureOr<void> imageLoadEvent(
      ImageLoadEvent event, Emitter<ContactDetailState> emit) async {
    try {
      List<String>? imagesList =
          await imageDatabase.getImageString(event.imageSource);
      emit(ImageLoadedState(imageString: imagesList));
    } on Exception catch (e) {
      emit(ContactErrorState(error: e.toString()));
    }
  }

  FutureOr<void> showBigImageEvent(
      ShowBigImageEvent event, Emitter<ContactDetailState> emit) {
    emit(ShowBigImageState(imageString: event.imageString));
  }

  FutureOr<void> loadAllImagesEvent(
      LoadAllImagesEvent event, Emitter<ContactDetailState> emit) async {
    emit(ContactProcessingState());
    try {
      var images = await contactsDatabase.getImagesOfOneRecord(event.id);
      if (images != null) {
        emit(AllImagesLoadedState(images: images.images));
      } else {
        emit(NoImageFoundState());
      }
    } catch (e) {
      emit(ContactErrorState(error: e.toString()));
    }
  }

  // //This method is called before new state is dispatched
  // @override
  // void onChange(Change<ContactDetailState> change) {
  //   print(change);
  //   super.onChange(change);
  // }

  // //
  // @override
  // void onEvent(ContactDetailEvent event) {
  //   print(event);
  //   super.onEvent(event);
  // }

  // @override
  // void onTransition(
  //     Transition<ContactDetailEvent, ContactDetailState> transition) {
  //   print(transition);
  //   super.onTransition(transition);
  // }

  FutureOr<void> fullScreenImagesEvent(
      FullScreenImagesEvent event, Emitter<ContactDetailState> emit) {
    emit(FullScreenImageState(images: event.images));
  }
}
