class Quiz {
  String title;
  String subTitle;
  String id;
  String grade;
  List<String> questions;
  String subject;

  Quiz(
      {required this.id,
      required this.title,
      required this.subTitle,
      required this.subject,
      required this.grade,
      required this.questions});
}
