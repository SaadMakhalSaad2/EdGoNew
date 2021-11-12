import 'package:flutter/material.dart';
import 'package:flutter_app/resources/constants.dart';

class HomeHeader extends StatelessWidget {
  final Map? user;
  const HomeHeader({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFF3366FF),
              Color(0xFF00CCFF),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
                radius: 30.0,
                backgroundImage:
                    NetworkImage( user!['imageUrl'] ?? Constants().profilePlaceholder,),
                backgroundColor: Colors.transparent,
              ),
          const Text('  |  '),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(user!['name']), Text(user!['email'])],
          )
        ],
      ),
    );
  }
}
