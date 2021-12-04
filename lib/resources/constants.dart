import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/quiz.dart';
import 'package:flutter_app/models/subject.dart';
import 'package:flutter_app/resources/resources.dart';
import 'package:flutter_app/screens/screens.dart';
import 'package:flutter_app/screens/wrapper.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
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
    required Map? user,
  }) async {
    final String useId = FirebaseAuth.instance.currentUser!.uid;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection = _firestore.collection('users');
    DocumentReference documentReferencer = _mainCollection.doc(useId);

    await documentReferencer.update(updates).whenComplete(() {
      snack('Profile updated', context);
      Constants().moveToPageWithReplacement(page: Wrapper(), context: context);
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

  Future<Map>? downloadUserProfile() async {
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

  Future<List<Subject>> downloadUserSubjects(String userGrade) async {
    print('userGrade: $userGrade');
    List<Subject> subjects = [];

    await FirebaseFirestore.instance
        .collection('grades')
        .doc(userGrade)
        .get()
        .then((value) async {
      print('grades: ${value.data()!['subjects']}');
      if (value.data()!['subjects'] != null) {
        for (var s in value.data()!['subjects']) {
          await FirebaseFirestore.instance
              .collection('subjects')
              .doc(s)
              .get()
              .then((snapSubjects) {
            if (snapSubjects.data() != null) {
              subjects.add(Subject(snapSubjects.data()!['title'],
                  snapSubjects.data()!['imageUrl']));
              print(
                  'subjects: ${Subject(snapSubjects.data()!['title'], snapSubjects.data()!['imageUrl'])}');
            }
          });
        }
        return subjects;
      }
    });

    return subjects;
  }

  displayLoadingSheet() {
    Get.bottomSheet(Text('Loading...'),
        isDismissible: false, barrierColor: Colors.grey.shade100);
  }

  Future<List<Quiz>> downloadQuizzes({required String subject}) async {
    print('quiz: $subject');
    List<Quiz> quizzes = [];

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('quizzes');

    QuerySnapshot querySnapshot = await _collectionRef.get();
    var m = querySnapshot.docs[0].data() as Map;
    m['id'];

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var m = querySnapshot.docs[i].data() as Map;
      Quiz quiz = Quiz(
          grade: m['grade']??'',
          id: m['id']??'',
          questions: m['questions'] ?? [],
          subject: m['subject']??'',
          subTitle: m['subTitle']??'',
          title: m['title']??'');
      if (quiz.subject == subject) quizzes.add(quiz);
    }

    return quizzes;
  }
}
