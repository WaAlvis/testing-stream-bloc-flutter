import 'dart:async';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text = "";

  final bloc = Bloc();

  @override
  void initState() {
    super.initState();
    bloc.clock.stream.listen((event) {
      setState(() {
        print(event);
        _text = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_text',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.startTimer();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Bloc {
  StreamController<String> clock = StreamController<String>();
  int a = 0;

  Bloc() {
    clock.sink.add("0");
    a = 0;
  }

  Future<void> startTimer() async {
    var counter = 0;
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      counter++;

      clock.sink.add('$counter');
      a = counter;
    }
  }
}