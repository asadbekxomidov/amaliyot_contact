import 'package:amaliyot_contact/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ContactProvider with ChangeNotifier {
  late Database _database;
  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  Future<void> initializeDB() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'contacts.db'),
      onCreate: (db, version) {
        return db.execute(
          """CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, contactName TEXT, phoneNumber TEXT)""",
        );
      },
      version: 1,
    );
    await fetchContacts();
  }

  Future<void> fetchContacts() async {
    final List<Map<String, dynamic>> maps = await _database.query('contacts');
    _contacts = List.generate(maps.length, (i) {
      return Contact.fromMap(maps[i]);
    });
    notifyListeners();
  }

  Future<void> addContact(Contact contact) async {
    await _database.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await fetchContacts();
  }

  Future<void> updateContact(Contact contact) async {
    await _database.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
    await fetchContacts();
  }

  Future<void> deleteContact(int id) async {
    await _database.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
    await fetchContacts();
  }
}
