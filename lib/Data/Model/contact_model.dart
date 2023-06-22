final String tableContacts = 'contacts';

class ContactFields {
  static final String id = '_id';
  static final String name = 'name';
  static final String email = 'email';
  static final String phoneNumber = 'phoneNumber';
  static final String isFavourite = 'isFavourite';
  static final String time = 'time';

  static final List<String> values = [
    id,
    name,
    email,
    phoneNumber,
    isFavourite,
    time
  ];
}

class Contact {
  final int? id;
  final String name;
  final String email;
  final String phoneNumber;
  final int isFavourite;
  final DateTime createdTime;

  Contact({
    this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.isFavourite,
    required this.createdTime,
  });

    Contact copy({
      int? id,
      String? name,
      String? email,
      String? phoneNumber,
      int? isFavourite,
      DateTime? createdTime,
    }) =>
      Contact(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        isFavourite: isFavourite ?? this.isFavourite,
        createdTime: createdTime ?? this.createdTime,
      );

  static Contact fromJson(Map<String, dynamic> json) => Contact(
      id: json[ContactFields.id] as int?,
      name: json[ContactFields.name] as String,
      email: json[ContactFields.email] as String,
      phoneNumber: json[ContactFields.phoneNumber] as String,
      isFavourite: json[ContactFields.isFavourite] as int,
      createdTime: DateTime.parse(json[ContactFields.time] as String));

  Map<String, dynamic> toJson() => {
    ContactFields.id : id,
    ContactFields.name: name,
    ContactFields.email : email,
    ContactFields.phoneNumber : phoneNumber,
    ContactFields.isFavourite : isFavourite,
    ContactFields.time : createdTime.toIso8601String(),
  };
}
