import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_streams/main2.dart';

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
  StreamController<String> streamController = StreamController<String>();

  @override
  void initState() {
    print('Creando el StreamController ...');

    streamController.stream.listen(
      (event) {
        print('listen de los eventos, data llegada... => $event');
      },
      onDone: () => print('Stream Done!!!'),
      onError: (error) => print('Stream  Error $error'),
    );

    print('Esta es la contiuacion del codigo initState...');
    super.initState();
    streamController.add('**Esto es un evendo agregado directamente**');
    getData();
  }

  @override
  void dispose() {

    streamController
        .close(); //Los Streams deben cerrarse cuando no se necesiten
    print("Nuestro Stream Controller ha sido Cerrado!!");
    super.dispose();
  }

  Future<String> getData() async {
    await Future.delayed(Duration(milliseconds: 5000));
    print("Fetched Data, despues de 5 segundos...");
    streamController.add('*Esta es la nueva data Retornada!!!*');
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
            const SizedBox(
              height: 20,
            ),
            Text(
              'Stream value: $_count',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  Route route = MaterialPageRoute(builder: (context) => Page2());
                  Navigator.pushReplacement(context, route);
                },
                child: Text('Navegar a page2')),
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
            heroTag: 'btn2',
            child: const Icon(Icons.add),
          ),
          // FloatingActionButton(
          //   onPressed: () {
          //     setState(() {});
          //   },
          //   tooltip: 'decrement',
          //   heroTag: 'btn2',
          //   child: const Icon(Icons.remove),
          // ),
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
