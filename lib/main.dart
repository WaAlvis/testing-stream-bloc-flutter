import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _count = 0;

  @override
  void initState() {
    print('Creando el Stream ...');
    Stream<String> stream = new Stream.fromFuture(getData());
    print('Stream Creado...');
    stream.listen(
      (event) {
        print('listen de los eventos, data llegada... => $event');
      },
      onDone: () => print('Stream Done!!!'),
      onError: (error) => print('Stream Error $error'),
    );

    print('Esta es la contiuacion del codigo initState...');
    super.initState();
  }

  Future<String> getData() async {
    await Future.delayed(Duration(milliseconds: 5000));
    print("Fetched Data, despues de 5 segundos...");
    return '*Esta es la nueva data Retornada!!!*';
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
            Text(
              '$_count',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Stream value: $_count',
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {});
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {});
            },
            tooltip: 'decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}

class Bloc {
  int _count;

  Bloc([this._count = 0]);

  void incrementCount() {
    _count++;
  }

  void decrementCount() {
    _count--;
  }

  Future<String> getData() async {
    await Future.delayed(Duration(seconds: 5)); // Retraso simulado
    print("Fetched Data");
    return "This a test data";
  }
}
