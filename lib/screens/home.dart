import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/resources/resources.dart';
import 'package:flutter_app/widgets/complete_profile_action.dart';
import 'package:flutter_app/widgets/home_header.dart';
import 'package:flutter_app/widgets/loading_widget.dart';
import 'package:flutter_app/widgets/subject_card.dart';
import 'package:flutter_app/widgets/subjects_grid.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class HomePage extends StatefulWidget {
  final Map? userObject;
  const HomePage({Key? key, required this.userObject}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bool completedProfile = true;
  @override
  Widget build(BuildContext context) {
    final user = widget.userObject;
    var userMap;

    return FutureBuilder<Map>(
        future: Constants().downloadUserProfile(),
        builder: (BuildContext context, AsyncSnapshot<Map> snap) {
          if (snap.connectionState == ConnectionState.waiting) {
           return const LoadingWidget();
          } else {
            if (snap.hasError) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.5,
                child: Scaffold(
                    body: Center(child: Text('HomePage:: ${snap.error}'))),
              );
            }
            bool profileUpdated = snap.data!['school'] != null;
            userMap = snap.data;
            return Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(top: 0, child: HomeHeader(user: snap.data)),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.3 -
                          (MediaQuery.of(context).size.height * 0.25) / 2,
                      child: profileUpdated
                          ? SbujectsGrid(grade: userMap['grade'])
                          : CompleteProfileAction(user: snap.data)),
                ],
              ),
            );
          }
        });
  }
}
