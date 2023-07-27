class MessageModel {
  String sender;
  String message;

  MessageModel({
    required this.sender,
    required this.message,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] ?? '',
        message = json['message'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'message': message,
    };
  }
}
