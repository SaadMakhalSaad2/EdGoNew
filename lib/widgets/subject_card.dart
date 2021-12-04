import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  String title;
  String imageUrl;
  SubjectCard({Key? key, required this.title, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      width: MediaQuery.of(context).size.width * 0.4,
      height: 100,
      child: Card(
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                imageUrl,
                width: 50,
                height: 50,
              ),
              const SizedBox(height: 8.0,),
              Text(title)
            ],
          )),
    );
  }
}
