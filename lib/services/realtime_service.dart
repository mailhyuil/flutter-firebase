import 'package:firebase_database/firebase_database.dart';

class RealtimeService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  late DatabaseReference _messagesRef;

  RealtimeService() {
    _messagesRef = _database.ref('messages');
  }

  Future<void> sendMessage(String senderId, String message) async {
    try {
      final messageRef = _messagesRef.push();
      await messageRef.set({
        'senderId': senderId,
        'message': message,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (error) {
      print('메시지 전송 오류: $error');
    }
  }

  Stream<DatabaseEvent> getMessagesStream() {
    return _messagesRef.orderByChild('timestamp').onValue;
  }
}
