import 'package:cloud_firestore/cloud_firestore.dart';

class MemoModel {
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  MemoModel({
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  MemoModel.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? '',
        content = json['content'] ?? '',
        createdAt = (json["createdAt"] as Timestamp).toDate(),
        updatedAt = (json["createdAt"] as Timestamp).toDate();

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
