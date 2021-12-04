import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/wrapper.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'screens/login.dart';

void main() async{  WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return StreamProvider<User?>.value(
      value: user,
      initialData: null,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
     
       home:  Wrapper(),
      ),
    );
  }

    Stream<User?> get user {
    return FirebaseAuth.instance.authStateChanges();
  }
}
