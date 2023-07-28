import 'package:flutter/material.dart';
import 'package:flutter_firebase/main.dart';
import 'package:flutter_firebase/models/memo_model.dart';
import 'package:flutter_firebase/services/firestore_service.dart';
import 'package:flutter_firebase/widgets/custom_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final firestoreService = locator<FirestoreService>();

  List<MemoModel> memos = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'Home',
      body: Column(
        children: [
          Flexible(
            child: Form(
              child: TextFormField(
                onFieldSubmitted: (value) {
                  firestoreService.createMemo(
                    MemoModel(
                        title: value,
                        content: 'content',
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now()),
                  );
                },
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<MemoModel>>(
              stream: firestoreService.getMemos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // 로딩 중이면 로딩 표시
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  memos = snapshot.data ?? []; // 스트림에서 가져온 데이터를 memos 리스트에 할당
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: memos.length,
                    itemBuilder: (context, index) {
                      return Flexible(
                        child: Text(memos[index].title),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
