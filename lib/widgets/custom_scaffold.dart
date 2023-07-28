import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/animation_screen.dart';
import 'package:flutter_firebase/screens/home_screen.dart';
import 'package:flutter_firebase/screens/realtime_screen.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final String appBarTitle;
  const CustomScaffold(
      {Key? key, required this.appBarTitle, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade100,
        title: Text(appBarTitle),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
            ),
            ListTile(
              title: const Text('Realtime'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RealtimeScreen()));
              },
            ),
            ListTile(
              title: const Text('Animation'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AnimationScreen()));
              },
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
