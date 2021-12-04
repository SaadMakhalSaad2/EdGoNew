import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/my_quizzes.dart';
import 'package:flutter_app/screens/settings.dart';
import 'package:flutter_app/widgets/custom_tab_bar.dart';
import 'package:page_transition/page_transition.dart';

class NavScreen extends StatefulWidget {
  final Map? user;
  const NavScreen({key, required this.user}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<IconData> icons = const [
    Icons.home,
    Icons.storage,
    Icons.settings
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    print('NavScreen: initState');
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomePage(
        userObject: {},
      ),
      const Quizzes(),
      SettingsPage(
        user: widget.user,
      )
    ];
    return DefaultTabController(
      length: icons.length,
      child: Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: screens,
          ),
          bottomNavigationBar: Container(
            color: Colors.white,
            child: CustomTapBar(
                icons: icons,
                selectedIndex: _selectedIndex,
                onTap: (index) => setState(() => _selectedIndex = index)),
          )),
    );
  }
}
