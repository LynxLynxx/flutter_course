// ignore_for_file: public_member_api_docs, sort_constructors_first
class TodoModel {
  final String text;
  bool isDone;

  TodoModel({
    required this.text,
    this.isDone = false,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        text: json["text"],
        isDone: json["isDone"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "isDone": isDone,
      };
}
