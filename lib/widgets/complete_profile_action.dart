import 'package:flutter/material.dart';
import 'package:flutter_app/resources/constants.dart';
import 'package:flutter_app/screens/profile_complete.dart';
import 'package:page_transition/page_transition.dart';

class CompleteProfileAction extends StatelessWidget {
  const CompleteProfileAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      child: GestureDetector(
        onTap:(){ Constants().moveToPage(page: const ProfileCompleteion(), context: context, type: PageTransitionType.bottomToTop);},
        child: Card(
          elevation: 8.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
                Text('Complete your profile to unlock app\'s functionality')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
