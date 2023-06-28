// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_contact_bloc/Data/Model/contact_model.dart';
import 'package:new_contact_bloc/View/Screens/contact_screen.dart';
import 'package:new_contact_bloc/View/Screens/contact_update_log.dart';
import '../../Logic/bloc/contact_detail/contact_detail_bloc.dart';

class AddNewContactScreen extends StatefulWidget {
  final Contact? contact;

  const AddNewContactScreen({
    super.key,
    this.contact,
  });

  @override
  State<AddNewContactScreen> createState() => _AddNewContactScreenState();
}

class _AddNewContactScreenState extends State<AddNewContactScreen> {
  // ignore: prefer_typing_uninitialized_variables
  late final _nameController;
  late final _emailController;
  late final _numberController;
  late int isFavourite;
  File? imagefile;
  String imageString = '';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact?.name);
    _emailController = TextEditingController(text: widget.contact?.email);
    _numberController =
        TextEditingController(text: widget.contact?.phoneNumber);
    isFavourite = widget.contact?.isFavourite ?? 0;
    if (widget.contact != null) {
      imageString = widget.contact!.imageString;
      if (widget.contact!.imageString != '') {
        imagefile = File(widget.contact!.imageString);
      } else if (imageString != '') {
        imagefile = File(imageString);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (widget.contact == null)
            ? const Text("Create New Contact")
            : const Text("Edit Contact"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<ContactDetailBloc, ContactDetailState>(
        listenWhen: (previous, current) => current is ContactDetailActionState,
        buildWhen: (previous, current) => current is! ContactDetailActionState,
        listener: (context, state) {
          if (state is MoveToBackPage) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const ContactScreen()));
          } else if (state is ShowModelBottomSheetOfPhoto) {
            showModalBottomSheet<void>(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              builder: (BuildContext context) {
                return FractionallySizedBox(
                  heightFactor: 0.5,
                  widthFactor: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Photo
                        Text(
                          "Photo",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //Image from gallary
                        TextButton(
                          child: Text(
                            "Take Photo from Gallery",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                            // context.read<ContactDetailBloc>().add(
                            //     GalarayImageSelected(
                            //         contact: Contact(
                            //             id: widget.contact?.id,
                            //             imageString: imageString,
                            //             name: _nameController.text,
                            //             email: _emailController.text,
                            //             phoneNumber: _numberController.text,
                            //             isFavourite: isFavourite,
                            //             createdTime:
                            //                 widget.contact?.createdTime ??
                            //                     DateTime.now(),
                            //             updatedTime:
                            //                 widget.contact?.updatedTime ??
                            //                     DateTime.now())));
                            context.read<ContactDetailBloc>().add(ImageLoadEvent(imageSource: ImageSource.gallery));
                            // await getImageString(ImageSource.gallery);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //Image from camera
                        TextButton(
                          child: Text(
                            "Take photo from camera",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            // context.read<ContactDetailBloc>().add(
                            //     CameraImageSelected(
                            //         contact: Contact(
                            //             id: widget.contact?.id,
                            //             name: _nameController.text,
                            //             email: _emailController.text,
                            //             phoneNumber: _numberController.text,
                            //             isFavourite: isFavourite,
                            //             createdTime:
                            //                 widget.contact?.createdTime ??
                            //                     DateTime.now(),
                            //             updatedTime:
                            //                 widget.contact?.updatedTime ??
                            //                     DateTime.now(),
                            //             imageString: ''))
                            //   );
                            context.read<ContactDetailBloc>().add(ImageLoadEvent(imageSource: ImageSource.camera));
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
        builder: (context, state) {
          if (state is ContactProcessingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ContactErrorState) {
            return Center(child: Text(state.error));
          } else if(state is ImageLoadedState){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    (state.imageString != null) 
                    ? CircleAvatar(
                        radius: 100,
                        child: ClipOval(
                          child: Image.file(
                            File(state.imageString!,),
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                            )
                          ),
                      ) 
                    : InkWell(
                            onTap: () {
                              context
                                  .read<ContactDetailBloc>()
                                  .add(ImageIconTapped());
                            },
                            child: const CircleAvatar(
                              radius: 60,
                              child: Icon(
                                Icons.person,
                                size: 110,
                              ),
                            ),
                    ),
                    // (imagefile != null)
                    //     ? CircleAvatar(
                    //         radius: 60,
                    //         child: Image.file(imagefile!),
                    //       )
                    //     : InkWell(
                    //         onTap: () {
                    //           context
                    //               .read<ContactDetailBloc>()
                    //               .add(ImageIconTapped());
                    //         },
                    //         child: const CircleAvatar(
                    //           radius: 60,
                    //           child: Icon(
                    //             Icons.person,
                    //             size: 110,
                    //           ),
                    //         ),
                    //       ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          label: const Text('Name'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          label: const Text('Email'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: const Text('Phone Number'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CheckboxListTile(
                        title: const Text('Is Favourite'),
                        value: (isFavourite == 1) ? true : false,
                        onChanged: (bool? value) {
                          setState(() {
                            (value!) ? (isFavourite = 1) : (isFavourite = 0);
                          });
                        }),
                    (widget.contact == null)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Cancel button
                              ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<ContactDetailBloc>()
                                        .add(CancelButtonTapped());
                                  },
                                  child: const Text("Cancel")),
                              const SizedBox(
                                width: 20,
                              ),
                              // Add button
                              ElevatedButton(
                                  onPressed: () {
                                    context.read<ContactDetailBloc>().add(
                                        AddButtonTapped(
                                            contact: Contact(
                                                imageString: state.imageString ?? imageString,
                                                name: _nameController.text,
                                                email: _emailController.text,
                                                phoneNumber:
                                                    _numberController.text,
                                                isFavourite: isFavourite,
                                                createdTime: DateTime.now(),
                                                updatedTime: DateTime.now())));
                                  },
                                  child: const Text("ADD")),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  // Cancel button
                                  ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<ContactDetailBloc>()
                                            .add(CancelButtonTapped());
                                      },
                                      child: const Text("Cancel")),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  // Update button
                                  ElevatedButton(
                                      onPressed: () {
                                        context.read<ContactDetailBloc>().add(
                                            UpdateButtonTapped(
                                                contact: Contact(
                                                    imageString: state.imageString ?? imageString,
                                                    id: widget.contact!.id,
                                                    name: _nameController.text,
                                                    email:
                                                        _emailController.text,
                                                    phoneNumber:
                                                        _numberController.text,
                                                    isFavourite: isFavourite,
                                                    createdTime: widget.contact
                                                            ?.createdTime ??
                                                        DateTime.now(),
                                                    updatedTime:
                                                        DateTime.now())));
                                      },
                                      child: const Text("Update")),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  // Delete button
                                  ElevatedButton(
                                      onPressed: () {
                                        context.read<ContactDetailBloc>().add(
                                            DeleteButtonTapped(
                                                id: widget.contact!.id!));
                                      },
                                      child: const Text("Delete")),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ContactUpdateLog(
                                                    id: widget.contact!.id!)));
                                  },
                                  child: const Text("Update Log")),
                            ],
                          )
                  ],
                ),
              ),
            );

          }else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    (imagefile != null)
                        ? CircleAvatar(
                            radius: 100,
                            // backgroundImage: FileImage(imagefile!),
                            child: ClipOval(
                          child: Image.file(
                            File(imageString),
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ))
                        : InkWell(
                            onTap: () {
                              context
                                  .read<ContactDetailBloc>()
                                  .add(ImageIconTapped());
                            },
                            child: const CircleAvatar(
                              radius: 60,
                              child: Icon(
                                Icons.person,
                                size: 110,
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          label: const Text('Name'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          label: const Text('Email'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: const Text('Phone Number'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CheckboxListTile(
                        title: const Text('Is Favourite'),
                        value: (isFavourite == 1) ? true : false,
                        onChanged: (bool? value) {
                          setState(() {
                            (value!) ? (isFavourite = 1) : (isFavourite = 0);
                          });
                        }),
                    (widget.contact == null)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Cancel button
                              ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<ContactDetailBloc>()
                                        .add(CancelButtonTapped());
                                  },
                                  child: const Text("Cancel")),
                              const SizedBox(
                                width: 20,
                              ),
                              // Add button
                              ElevatedButton(
                                  onPressed: () {
                                    context.read<ContactDetailBloc>().add(
                                        AddButtonTapped(
                                            contact: Contact(
                                                imageString: imageString,
                                                name: _nameController.text,
                                                email: _emailController.text,
                                                phoneNumber:
                                                    _numberController.text,
                                                isFavourite: isFavourite,
                                                createdTime: DateTime.now(),
                                                updatedTime: DateTime.now())));
                                  },
                                  child: const Text("ADD")),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  // Cancel button
                                  ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<ContactDetailBloc>()
                                            .add(CancelButtonTapped());
                                      },
                                      child: const Text("Cancel")),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  // Update button
                                  ElevatedButton(
                                      onPressed: () {
                                        context.read<ContactDetailBloc>().add(
                                            UpdateButtonTapped(
                                                contact: Contact(
                                                    imageString: imageString,
                                                    id: widget.contact!.id,
                                                    name: _nameController.text,
                                                    email:
                                                        _emailController.text,
                                                    phoneNumber:
                                                        _numberController.text,
                                                    isFavourite: isFavourite,
                                                    createdTime: widget.contact
                                                            ?.createdTime ??
                                                        DateTime.now(),
                                                    updatedTime:
                                                        DateTime.now())));
                                      },
                                      child: const Text("Update")),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  // Delete button
                                  ElevatedButton(
                                      onPressed: () {
                                        context.read<ContactDetailBloc>().add(
                                            DeleteButtonTapped(
                                                id: widget.contact!.id!));
                                      },
                                      child: const Text("Delete")),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ContactUpdateLog(
                                                    id: widget.contact!.id!)));
                                  },
                                  child: const Text("Update Log")),
                            ],
                          )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
  }

  // Future<void> getImageString(ImageSource imageSource) async {
  //   final File? pickedImage = await pickImage(imageSource);
  //   if (pickedImage != null) {
  //     final String fileName = basename(pickedImage.path);
  //     final Directory appDir = await getApplicationDocumentsDirectory();
  //     final String imagePath = '${appDir.path}/$fileName';
  //     imageString = imagePath;
  //   }
  //   return null;
  // }

  // Future<File?> pickImage(ImageSource imageSource) async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: imageSource);

  //   if (pickedFile != null) {
  //     return File(pickedFile.path);
  //   }

  //   return null;
  // }
}
