import 'dart:math';

import 'package:amaliyot_contact/models/contact.dart';
import 'package:amaliyot_contact/controllers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ContactsScreen extends StatefulWidget {
  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Contacts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.purple.shade300,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: contactProvider.contacts.length,
              itemBuilder: (context, index) {
                final contact = contactProvider.contacts[index];
                return ListTile(
                  leading: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                        230,
                        Random().nextInt(255),
                        Random().nextInt(255),
                        Random().nextInt(255),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(contact.contactName),
                  subtitle: Text(contact.phoneNumber),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 25,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          _nameController.text = contact.contactName;
                          _phoneController.text = contact.phoneNumber;
                          _showDialog(
                            context,
                            contactProvider,
                            contact: contact,
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 25,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          contactProvider.deleteContact(contact.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _nameController.clear();
          _phoneController.clear();
          _showDialog(context, contactProvider);
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
        shape: CircleBorder(),
        backgroundColor: Colors.purple.shade300,
      ),
    );
  }

  void _showDialog(BuildContext context, ContactProvider provider,
      {Contact? contact}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(contact == null ? 'Add Contact' : 'Edit Contact'),
          content: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ZoomTapAnimation(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red.shade300,
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
                ZoomTapAnimation(
                  onTap: () {
                    if (contact == null) {
                      provider.addContact(Contact(
                        id: provider.contacts.length + 1,
                        contactName: _nameController.text,
                        phoneNumber: _phoneController.text,
                      ));
                    } else {
                      provider.updateContact(Contact(
                        id: contact.id,
                        contactName: _nameController.text,
                        phoneNumber: _phoneController.text,
                      ));
                    }
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.green.shade300,
                    ),
                    child: Center(
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
