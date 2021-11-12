import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/resources/resources.dart';
import 'package:flutter_app/screens/screens.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:page_transition/page_transition.dart';

class Constants {
  moveToPageWithReplacement(
      {required Widget page,
      required BuildContext context,
      PageTransitionType type = PageTransitionType.rightToLeft}) {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: type,
            duration: const Duration(milliseconds: 300),
            child: page));
  }

  final profilePlaceholder =
      'https://firebasestorage.googleapis.com/v0/b/edgo-d3450.appspot.com/o/image%20(4).png?alt=media&token=6e25afee-8fcf-4c50-84fe-fa91bc588249';
  moveToPage(
      {required Widget page,
      required BuildContext context,
      PageTransitionType type = PageTransitionType.rightToLeft}) {
    Navigator.push(
        context,
        PageTransition(
            type: type,
            duration: const Duration(milliseconds: 300),
            child: page));
  }

  signOut() {
    FacebookAuth.instance.logOut();
    FirebaseAuth.instance.signOut();
    print('logged out ${FirebaseAuth.instance.currentUser}');
  }

  Future<void> addUser({
    required String userFbId,
    required String email,
    required String name,
    required String imageUrl,
    required context,
    required userObj,
  }) async {
    final String useId = FirebaseAuth.instance.currentUser!.uid;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection = _firestore.collection('users');

    DocumentReference documentReferencer = _mainCollection.doc(useId);

    Map<String, dynamic> data = <String, dynamic>{
      "id": useId,
      "email": email,
      'fbId': userFbId,
      'name': name,
      'imageUrl': imageUrl
    };

    await documentReferencer.set(data).whenComplete(() {
      print("Notes item added to the database ${data}");
      Constants().moveToPageWithReplacement(
        page: HomePage(
          userObject: userObj,
        ),
        context: context,
      );
    }).catchError((e) => print(e));
  }

  Stream<QuerySnapshot> readProfile() {
    final String useId = FirebaseAuth.instance.currentUser!.uid;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection = _firestore.collection('users');

    CollectionReference notesItemCollection =
        _mainCollection.doc(useId).collection('items');

    return notesItemCollection.snapshots();
  }

  updateUserProfile({
    required Map<String, dynamic> updates,
    required BuildContext context,
  }) async {
    final String useId = FirebaseAuth.instance.currentUser!.uid;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection = _firestore.collection('users');
    DocumentReference documentReferencer = _mainCollection.doc(useId);

    

    await documentReferencer.update(updates).whenComplete(() {
      snack('Profile updated', context);
    }).catchError((e) => print(e));
  }

  snack(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Palette.primaryColor,
      content: Text(
        msg.toString(),
        style: const TextStyle(color: Colors.white60),
      ),
    ));
  }
}
