import 'package:flutter/material.dart';
import 'package:flutter_app/resources/constants.dart';
import 'package:flutter_app/resources/palette.dart';

class ProfileCompleteion extends StatefulWidget {
  final Map? user;
  const ProfileCompleteion(
      {Key? key, required this.user})
      : super(key: key);

  @override
  State<ProfileCompleteion> createState() => _ProfileCompleteionState();
}

class _ProfileCompleteionState extends State<ProfileCompleteion> {
  String selectedGrade = '';
  String previousGrade = '';
  TextEditingController schoolController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    previousGrade = widget.user!['grade'] ?? '';
    schoolController.text = widget.user!['school'];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Complete Profile'),
          actions: [
            FloatingActionButton(
              elevation: 0,
              mini: true,
              child: const Icon(
                Icons.save,
                color: Palette.primaryColor,
              ),
              onPressed: () {
                _updateProfile();
              },
              backgroundColor: Colors.white,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: schoolController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'School',
                    icon: Icon(Icons.school)),
              ),
              DropdownButtonFormField<String>(
                value: previousGrade,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.person),
                ),
                hint: const Text("Please choose account type"),
                items: <String>['Grade 9', 'Grade 10', 'Grade 11', 'Grade 12'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (grade) {
                  setState(() {
                    selectedGrade = grade.toString();
                  });
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ));
  }

  _updateProfile() {
    if (schoolController.text.isEmpty || schoolController.text.length < 6) {
      Constants().snack('Invalid school name', context);
      return;
    }
    if (selectedGrade.isEmpty && previousGrade.isEmpty) {
      Constants().snack('Invalid grade', context);
      return;
    }

    Constants().updateUserProfile(updates: {
      'school': schoolController.text.toString(),
      'grade': selectedGrade.isNotEmpty ? selectedGrade: previousGrade,
    }, context: context, user: widget.user);
  }
}
