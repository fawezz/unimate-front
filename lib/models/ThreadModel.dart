import 'package:univ_chat_gpt/models/QuestionModel.dart';

class Thread {
  String title = "undetermined";
  String? user;
  String? id;
  DateTime? updatedAt;
  DateTime? createdAt;
  List<Question> questions = <Question>[];

  Thread({required this.questions,this.user,this.id});

  Thread.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    user = json['user'];
    id = json['_id'];
    updatedAt = DateTime.parse(json['updatedAt']);
    createdAt = DateTime.parse(json['createdAt']);

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
