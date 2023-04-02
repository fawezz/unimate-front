class Question {
  String? prompt;
  String? completion;
  String? tag;
  String? subtag;
  String? thread;
  String? id;

  Question(
      {this.prompt,
      this.completion,
      this.tag,
      this.subtag,
      this.thread,
      this.id});

  Question.fromJson(Map<String, dynamic> json) {
    prompt = json['prompt'];
    completion = json['completion'];
    tag = json['tag'];
    subtag = json['subtag'];
    thread = json['thread'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['prompt'] = prompt;
    data['completion'] = completion;
    data['tag'] = tag;
    data['subtag'] = subtag;
    data['thread'] = thread;
    data['_id'] = id;
    return data;
  }
}
