
import 'package:get/get.dart';
class UserProfile {
  String name;
  String email;
  String id;
  String school;

  var grade = ''.obs;

  UserProfile(
      {required this.name,
      required this.email,
      required this.id,
      required this.school,
      required this.grade});
}
