import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoggedIn = false;
  Map _userObj = {};

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Codesundar"),
      ),
      body: Container(
        child: _isLoggedIn
            ? Column(
          children: [
            Image.network(_userObj["picture"]["data"]["url"]),
            Text(_userObj["name"]),
            Text(_userObj["email"]),
            TextButton(
                onPressed: () {
                  FacebookAuth.instance.logOut().then((value) {
                    setState(() {
                      _isLoggedIn = false;
                      _userObj = {};
                    });
                  });
                },
                child: Text("Logout"))
          ],
        )
            : Center(
          child: ElevatedButton(
            child: Text("Login with Facebook"),
            onPressed: () async {
              // FacebookAuth.instance.login(
              //     permissions: ["public_profile", "email"]).then((value) {
              //   FacebookAuth.instance.getUserData().then((userData) {
              //     setState(() {
              //       _isLoggedIn = true;
              //       _userObj = userData;
              //     });
              //   });
              // });
              signInWithFacebook();
            },
          ),
        ),
      ),
    );
  }
}