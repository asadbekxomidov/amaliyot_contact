import 'package:amaliyot_contact/views/screens/contact_screen.dart';
import 'package:amaliyot_contact/controllers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContactProvider()..initializeDB(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ContactsScreen(),
      ),
    );
  }
}
