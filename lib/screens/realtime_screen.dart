import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/main.dart';
import 'package:flutter_firebase/services/realtime_service.dart';
import 'package:flutter_firebase/widgets/custom_scaffold.dart';

class RealtimeScreen extends StatefulWidget {
  const RealtimeScreen({Key? key}) : super(key: key);

  @override
  _RealtimeScreenState createState() => _RealtimeScreenState();
}

class _RealtimeScreenState extends State<RealtimeScreen> {
  final _realtimeService = locator<RealtimeService>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'Realtime',
      body: Column(
        children: [
          Form(
            child: TextFormField(
              onFieldSubmitted: (value) {
                _realtimeService.sendMessage('senderId', value);
              },
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<DatabaseEvent>(
              stream: _realtimeService.getMessagesStream(),
              builder: (context, snapshot) {
                return Text(snapshot.data.toString());
              },
            ),
          ),
        ],
      ),
    );
  }
}
