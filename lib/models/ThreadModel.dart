import 'package:univ_chat_gpt/models/QuestionModel.dart';

class Thread {
  String title = "undetermined";
  String? user;
  String? id;
  List<Question> questions = <Question>[];

  Thread({required this.questions, required this.user, required this.id});

  Thread.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    user = json['user'];
    id = json['_id'];

    questions = <Question>[];
    List<dynamic> jsonQuestions = json['questions'];
    jsonQuestions.forEach((element) {
      questions.add(Question.fromJson(element));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['user'] = user;
    data['_id'] = id;
    List<Map> jsonQuestions = questions.map((q) => q.toJson()).toList();
    data['questions'] = jsonQuestions;

    return data;
  }
}
