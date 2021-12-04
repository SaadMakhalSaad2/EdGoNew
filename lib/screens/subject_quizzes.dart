import 'package:flutter/material.dart';
import 'package:flutter_app/models/quiz.dart';
import 'package:flutter_app/models/subject.dart';
import 'package:flutter_app/resources/constants.dart';
import 'package:flutter_app/widgets/loading_widget.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

class SubjectQuizzes extends StatefulWidget {
  String subject;
  SubjectQuizzes({Key? key, required this.subject}) : super(key: key);

  @override
  State<SubjectQuizzes> createState() => _SubjectQuizzesState();
}

class _SubjectQuizzesState extends State<SubjectQuizzes> {
  List<String> labels = ['New', 'Taken'];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subject} quizzes'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            FlutterToggleTab(
              width: 90,
              borderRadius: 30,
              height: 50,
              selectedIndex: currentIndex,
              selectedTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
              unSelectedTextStyle: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              labels: labels,
              selectedLabelIndex: (index) {
                setState(() {
                  currentIndex = index;
                });
                print("Selected Index $index");
              },
            ),
            FutureBuilder<List<Quiz>>(
                future: Constants().downloadQuizzes(subject: widget.subject),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Quiz>> snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const LoadingWidget();
                  } else {
                    if (snap.hasError) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 0.5,
                        child: Scaffold(
                            body: Center(
                                child: Text('HomePage:: ${snap.error}'))),
                      );
                    }

                    return Column(
                      children: [
                        Text(snap.data!.length.toString()),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 158,
                          child: ListView.builder(
                              itemCount: snap.data!.length,
                              itemBuilder: (context, index) {
                                Quiz quiz = snap.data![index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 100, horizontal: 4),
                                  child: Card(
                                    child: Text(quiz.title),
                                  ),
                                );
                              }),
                        )
                      ],
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
