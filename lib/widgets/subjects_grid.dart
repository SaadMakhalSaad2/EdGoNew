import 'package:flutter/material.dart';
import 'package:flutter_app/models/subject.dart';
import 'package:flutter_app/resources/resources.dart';
import 'package:flutter_app/screens/subject_quizzes.dart';
import 'package:flutter_app/widgets/loading_widget.dart';
import 'package:flutter_app/widgets/subject_card.dart';
import 'package:get/get.dart';

class SbujectsGrid extends StatelessWidget {
  String grade;
  SbujectsGrid({Key? key, required this.grade}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Subject>>(
        future: Constants().downloadUserSubjects(grade),
        builder:
            (BuildContext context, AsyncSnapshot<List<Subject>> snapSubject) {
          if (snapSubject.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else {
            if (snapSubject.hasError) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.5,
                child: Scaffold(
                    body:
                        Center(child: Text('HomePage:: ${snapSubject.error}'))),
              );
            }
          }
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: snapSubject.data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(SubjectQuizzes(
                            subject: snapSubject.data![index].title));
                      },
                      child: SubjectCard(
                        imageUrl: snapSubject.data![index].imageUrl,
                        title: snapSubject.data![index].title,
                      ),
                    );
                  },
                )

                // ...... other list children.
              ],
            ),
          );
        });
  }
}
