import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/quizzes.dart';
import 'package:flutter_app/screens/settings.dart';
import 'package:flutter_app/widgets/custom_tab_bar.dart';
import 'package:page_transition/page_transition.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> screens = [
    const HomePage(
      userObject: {},
    ),
    const Quizzes(),
     SettingsPage()
  ];

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
