import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home_screen.dart';
import 'package:flutter_firebase/widgets/custom_scaffold.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({Key? key}) : super(key: key);

  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _x = 0;
  double _y = 0;
  double theta = 0;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 50),
    );

    _controller.addListener(() {
      setState(() {
        _x++;
        _y = sin(theta) * 100;
        theta += 0.1;
      });
    });

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "Animation",
      body: Stack(children: [
        for (int i = 0; i < 10; i++)
          Positioned(
            left: _x,
            top: _y + i * 20,
            child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('The number is..'),
                          content: Text(i.toString()),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const HomeScreen();
                                      },
                                    ),
                                  );
                                },
                                child: const Text('OK')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('DISMISS'))
                          ],
                        );
                      });
                },
                child: Text(i.toString())),
          ),
      ]),
    );
  }
}
