import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/resources/constants.dart';
import 'package:flutter_app/widgets/settings_card.dart';
import 'package:page_transition/page_transition.dart';

class SettingsPage extends StatefulWidget {
 
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController dietaryController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Constants().signOut();
                },
                child: const SettingsCard(icon: Icons.logout, title: 'logout')),
            const SizedBox(height: 16.0),
       
          ],
        ),
      ),
    );
  }



}