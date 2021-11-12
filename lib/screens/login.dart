import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/resources/resources.dart';
import 'package:flutter_app/screens/screens.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoggedIn = false;
  Map _userObj = {};

  @override
  Widget build(BuildContext context) {
    _isLoggedIn = FirebaseAuth.instance.currentUser != null ? true : false;
    return Scaffold(
      body: Container(
        child: _isLoggedIn
            ? Column(
                children: [
                  TextButton(
                      onPressed: () {
                        FacebookAuth.instance.logOut().then((value) {
                          setState(() {
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
                    signInWithFacebook();
                  },
                ),
              ),
      ),
    );
  }

  signInWithFacebook() async {
    String imageUrl = '';
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]).then((value) {
      FacebookAuth.instance.getUserData().then((userData) {
        imageUrl = userData['picture']['data']['url'];
        setState(() {
          _userObj = userData;
        });
      });
      return value;
    });

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential)
        .then((value) => {
              Constants().addUser(
                  userFbId: value.user!.uid,
                  email: value.user!.email.toString(),
                  name: value.user!.displayName.toString(),
                  imageUrl:imageUrl.toString(),
                  context: context,
                  userObj: _userObj)
            });
  }
}
