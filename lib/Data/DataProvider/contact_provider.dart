import 'package:hive/hive.dart';
import 'package:new_contact_bloc/Data/Model/contact_model_hive.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../Model/contact_model.dart';

class ContactsDatabase {
  static final ContactsDatabase instance = ContactsDatabase._init();

  static Database? _database;

  ContactsDatabase._init();

  Box<ContactModelHive> contactsBox =
      Hive.box<ContactModelHive>("contactInHive");

  Future<Database> get database async {
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

  Future<Contact> create(Contact contact) async {
    final db = await instance.database;
    final id = await db.insert(tableContacts, contact.toJson());
    print(id);
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

  ContactModelHive? getContactUpdateLog(int id) {
    return contactsBox.get(id);
  }

  Future<int> update(Contact contact) async {
    await contactsBox.put(
        contact.id,
        ContactModelHive(
            name: contact.name,
            email: contact.email,
            phoneNumber: contact.phoneNumber,
            isFavourite: contact.isFavourite,
            createdTime: contact.createdTime,
            updatedTime: contact.updatedTime));
    contactsBox.add(ContactModelHive(
        name: contact.name,
        email: contact.email,
        phoneNumber: contact.phoneNumber,
        isFavourite: contact.isFavourite,
        createdTime: contact.createdTime,
        updatedTime: contact.updatedTime));
    final db = await instance.database;

    return db.update(
      tableContacts,
      contact.toJson(),
      where: '${ContactFields.id} = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableContacts,
      where: '${ContactFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
