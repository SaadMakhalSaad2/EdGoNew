import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/resources/resources.dart';
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
      return  FutureBuilder<Map>(
        future: Constants().downloadUserProfile(),
        builder: (BuildContext context, AsyncSnapshot<Map> snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 65.0,
              child: const Scaffold(
                  body: Center(child: Text('Please wait its loading...'))),
            );
          } else {
            if (snap.hasError) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.5,
                child: Scaffold(
                    body: Center(child: Text('HomePage:: ${snap.error}'))),
              );
            }
            return  NavScreen(user: snap.data);
          }
        });
    } else {
      return LoginPage();
    }
  }
}
