import 'package:firebase_database/firebase_database.dart';

class RealtimeService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  late DatabaseReference _messagesRef;

  RealtimeService() {
    _messagesRef = _database.ref('messages');
  }

  Future<void> sendMessage(String sender, String message) async {
    try {
      final messageRef = _messagesRef.push();
      await messageRef.set({
        'sender': sender,
        'message': message,
      });
    } catch (error) {
      print('메시지 전송 오류: $error');
    }
  }

  Stream<DatabaseEvent> getMessagesStream() {
    return _messagesRef.onValue;
  }
}
