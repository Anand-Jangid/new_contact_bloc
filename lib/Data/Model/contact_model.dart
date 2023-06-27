const String tableContacts = 'contacts';

class ContactFields {
  static const String id = '_id';
  static const String name = 'name';
  static const String email = 'email';
  static const String phoneNumber = 'phoneNumber';
  static const String isFavourite = 'isFavourite';
  static const String time = 'time';
  static const String updatedTime = 'updatedTime';
  static const String imageString = 'imageString';

  static final List<String> values = [
    id,
    name,
    email,
    phoneNumber,
    isFavourite,
    time,
    updatedTime,
    imageString
  ];
}

class Contact {
  final int? id;
  final String name;
  final String email;
  final String phoneNumber;
  final int isFavourite;
  final DateTime createdTime;
  final DateTime updatedTime;
  final String imageString;

  Contact(
      {this.id,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.isFavourite,
      required this.createdTime,
      required this.updatedTime,
      required this.imageString});

  Contact copy(
          {int? id,
          String? name,
          String? email,
          String? phoneNumber,
          int? isFavourite,
          DateTime? createdTime,
          DateTime? updatedTime,
          String? imageString}) =>
      Contact(
          id: id ?? this.id,
          name: name ?? this.name,
          email: email ?? this.email,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          isFavourite: isFavourite ?? this.isFavourite,
          createdTime: createdTime ?? this.createdTime,
          updatedTime: updatedTime ?? this.updatedTime,
          imageString: imageString ?? this.imageString);

  static Contact fromJson(Map<String, dynamic> json) => Contact(
      id: json[ContactFields.id] as int?,
      name: json[ContactFields.name] as String,
      email: json[ContactFields.email] as String,
      phoneNumber: json[ContactFields.phoneNumber] as String,
      isFavourite: json[ContactFields.isFavourite] as int,
      createdTime: DateTime.parse(json[ContactFields.time] as String),
      updatedTime: DateTime.parse(json[ContactFields.updatedTime] as String),
      imageString: json[ContactFields.imageString] as String);

  Map<String, dynamic> toJson() => {
        ContactFields.id: id,
        ContactFields.name: name,
        ContactFields.email: email,
        ContactFields.phoneNumber: phoneNumber,
        ContactFields.isFavourite: isFavourite,
        ContactFields.time: createdTime.toIso8601String(),
        ContactFields.updatedTime: updatedTime.toIso8601String(),
        ContactFields.imageString: imageString,
      };
}
