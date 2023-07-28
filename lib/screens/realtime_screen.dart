import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/main.dart';
import 'package:flutter_firebase/models/message_model.dart';
import 'package:flutter_firebase/services/realtime_service.dart';
import 'package:flutter_firebase/widgets/custom_scaffold.dart';

class RealtimeScreen extends StatefulWidget {
  const RealtimeScreen({Key? key}) : super(key: key);
  @override
  _RealtimeScreenState createState() => _RealtimeScreenState();
}

class _RealtimeScreenState extends State<RealtimeScreen> {
  final _realtimeService = locator<RealtimeService>();
  List<MessageModel> messages = [];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'Realtime',
      body: Column(
        children: [
          Flexible(
            child: Form(
              child: TextFormField(
                onFieldSubmitted: (value) {
                  _realtimeService.sendMessage('hyuil', value);
                },
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<DatabaseEvent>(
              stream: _realtimeService.getMessagesStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  final values =
                      (snapshot.data!.snapshot.value as Map<Object?, Object?>)
                          .values;
                  messages.clear();
                  for (var element in values) {
                    final encoded = jsonEncode(element);
                    final decoded = jsonDecode(encoded);
                    MessageModel model = MessageModel.fromJson(decoded);
                    messages.add(model);
                  }
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(messages[index].message),
                          Text(messages[index].sender),
                        ],
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
