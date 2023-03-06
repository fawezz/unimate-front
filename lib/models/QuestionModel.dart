class Question {
  String? prompt;
  String? completion;
  String? tag;
  String? subtag;
  String? user;
  String? id;

  Question(
      {this.prompt,
      this.completion,
      this.tag,
      this.subtag,
      this.user,
      this.id});

  Question.fromJson(Map<String, dynamic> json) {
    prompt = json['prompt'];
    completion = json['completion'];
    tag = json['tag'];
    subtag = json['subtag'];
    user = json['user'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prompt'] = prompt;
    data['completion'] = completion;
    data['tag'] = tag;
    data['subtag'] = subtag;
    data['user'] = user;
    data['_id'] = id;
    return data;
  }
}
