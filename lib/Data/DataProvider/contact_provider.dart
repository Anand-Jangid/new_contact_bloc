import 'package:hive/hive.dart';
import 'package:new_contact_bloc/Data/Model/contact_model_hive.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../Model/contact_model.dart';
import '../Model/image_model_hive.dart';

class ContactsDatabase {
  static final ContactsDatabase instance = ContactsDatabase._init();

  static Database? _database;

  ContactsDatabase._init();

  late Box<ContactModelHive> contactsBox;
  late Box<ImageModelHive> imagesBox;

  Future<Database> get database async {
    await Hive.openBox<ContactModelHive>("contactInHive");
    contactsBox = Hive.box<ContactModelHive>("contactInHive");

    await Hive.openBox<ImageModelHive>("imagesInHive");
    imagesBox = Hive.box<ImageModelHive>("imagesInHive");
    if (_database != null) return _database!;
    _database = await _initDB('contacts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE $tableContacts ( 
        ${ContactFields.id} $idType, 
        ${ContactFields.name} $textType,
        ${ContactFields.email} $textType,
        ${ContactFields.phoneNumber} $textType,
        ${ContactFields.isFavourite} $boolType,
        ${ContactFields.time} $textType,
        ${ContactFields.updatedTime} $textType
        )
      ''');
  }

  Future<Contact> create(Contact contact, List<String>? images) async {
    final db = await instance.database;
    final id = await db.insert(tableContacts, contact.toJson());
    //Storing contact log in hive
    await contactsBox.put(
        id.toString(),
        ContactModelHive(
            name: [contact.name],
            email: [contact.email],
            phoneNumber: [contact.phoneNumber],
            isFavourite: [contact.isFavourite],
            createdTime: [contact.createdTime],
            updatedTime: [contact.updatedTime]));
    //Storing images list in hive
    if (images != null && images.isNotEmpty) {
      await imagesBox.put(
          id.toString(), ImageModelHive(contactId: id, images: images));
    }
    return contact.copy(id: id);
  }

  // Future<Contact> readContact(int id) async {
  //   final db = await instance.database;
  //   final maps = await db.query(
  //     tableContacts,
  //     columns: ContactFields.values,
  //     where: '${ContactFields.id} = ?',
  //     whereArgs: [id],
  //   );
  //   if (maps.isNotEmpty) {
  //     return Contact.fromJson(maps.first);
  //   } else {
  //     throw Exception('ID $id not found');
  //   }
  // }

  Future<List<Contact>> readAllContacts() async {
    final db = await instance.database;
    final orderBy = '${ContactFields.time} ASC';
    final result = await db.query(tableContacts, orderBy: orderBy);
    return result.map((json) => Contact.fromJson(json)).toList();
  }

  Future<ContactModelHive> getContactUpdateLog(int id) async {
    var contacts = contactsBox.get(id.toString());
    return contacts!;
  }

  Future<ImageModelHive?> getImagesOfOneRecord(int id) async {
    var images = imagesBox.get(id.toString());
    if (images != null) {
      return images;
    }
    return null;
  }

  Future<int> update(Contact contact, List<String>? imagesFromUser) async {
    if (contactsBox.containsKey(contact.id.toString())) {
      var getContacts = contactsBox.get(contact.id.toString());
      List<String> nameList = getContacts!.name;
      List<String> emailList = getContacts.email;
      List<String> phoneNumberList = getContacts.phoneNumber;
      List<int> isFavouriteList = getContacts.isFavourite;
      List<DateTime> createdDateList = getContacts.createdTime;
      List<DateTime> updatedDateList = getContacts.updatedTime;
      nameList.insert(0, contact.name);
      emailList.insert(0, contact.email);
      phoneNumberList.insert(0, contact.phoneNumber);
      isFavouriteList.insert(0, contact.isFavourite);
      createdDateList.insert(0, contact.createdTime);
      updatedDateList.insert(0, contact.updatedTime);
      var newContact = ContactModelHive(
          name: nameList,
          email: emailList,
          phoneNumber: phoneNumberList,
          isFavourite: isFavouriteList,
          createdTime: createdDateList,
          updatedTime: updatedDateList);
      await contactsBox.put(contact.id.toString(), newContact);
    } else {
      await contactsBox.put(
          contact.id.toString(),
          ContactModelHive(
              name: [contact.name],
              email: [contact.email],
              phoneNumber: [contact.phoneNumber],
              isFavourite: [contact.isFavourite],
              createdTime: [contact.createdTime],
              updatedTime: [contact.updatedTime]));
    }

    ///Update image record in Hive
    if (imagesBox.containsKey(contact.id.toString())) {
      var getImagesModel = imagesBox.get(contact.id.toString());
      if (getImagesModel != null) {
        var imagesFromHive = getImagesModel.images;
        if (imagesFromHive != null && imagesFromUser != null) {
          imagesFromHive.addAll(imagesFromUser);
        }
        //! Update hive record
      }
      // List<String> images = getImages.images;
      // images.addA(contact.imageString);
      // // var newContact = ContactModelHive(
      // //     name: nameList,
      // //     email: emailList,
      // //     phoneNumber: phoneNumberList,
      // //     isFavourite: isFavouriteList,
      // //     createdTime: createdDateList,
      // //     updatedTime: updatedDateList);
      // var newImage = ImageModelHive(
      //   contactId: contact.id!, images: [contact.imageString])
      // await contactsBox.put(contact.id.toString(), newContact);
    } else {
      if (imagesFromUser != null) {
        await imagesBox.put(contact.id.toString(),
            ImageModelHive(contactId: contact.id!, images: imagesFromUser));
      }
    }
    final db = await instance.database;
    return db.update(
      tableContacts,
      contact.toJson(),
      where: '${ContactFields.id} = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> delete(int id) async {
    //first deleting from hive its change log
    contactsBox.delete(id.toString());

    /// we also need to delete images in hive
    imagesBox.delete(id.toString());
    
    final db = await instance.database;

    return await db.delete(
      tableContacts,
      where: '${ContactFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    //closing box
    await contactsBox.close();
    final db = await instance.database;
    db.close();
  }
}
