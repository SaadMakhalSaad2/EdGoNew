import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/screens/nav_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
// FirebaseServices().signOut();
    final user = Provider.of<User?>(context);
    print('stream data: ${user}');

    if (user != null) {
      return NavScreen();
    } else {
      return LoginPage();
    }
  }
}
