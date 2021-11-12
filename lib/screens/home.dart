import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/complete_profile_action.dart';
import 'package:flutter_app/widgets/home_header.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class HomePage extends StatefulWidget {
  final Map userObject;
  const HomePage({Key? key, required this.userObject}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bool completedProfile = true;
  @override
  Widget build(BuildContext context) {
    final user = widget.userObject;

    return FutureBuilder<Map>(
        future: _downloadUserProfile(),
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
            return Scaffold(
              body: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(top: 0, child: HomeHeader(user: snap.data)),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.3 -
                          (MediaQuery.of(context).size.height * 0.15) / 2,
                      child: const CompleteProfileAction())
                ],
              ),
            );
          }
        });
  }

  Future<Map>? _downloadUserProfile() async {
    var data;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get()
        .then((querySnapshot) {
      data = querySnapshot.data();
      print('query: $querySnapshot');
      return data;
    });
    return data;
  }
}
