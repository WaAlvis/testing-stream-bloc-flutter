import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_streams/main2.dart';

// https://medium.com/comunidad-flutter/usando-streams-en-flutter-28c9357772a9

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
        useMaterial3: true,
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
  StreamController<String> streamController =
      StreamController.broadcast(); //Agrega .broadcast acá

  @override
  void initState() {
    super.initState();
    print('Creando el StreamController ...');
//Primera subscripción
    streamController.stream.listen(
      (event) {
        print('listen de los eventos, data llegada...En Stream*1 => $event');
      },
      onDone: () => print('Stream*1 Done!!!'),
      onError: (error) => print('Stream  Error $error'),
    );
//Segunda Subscription
    streamController.stream.listen(
      (event) {
        print('listen de los eventos, data llegada...En Stream*2 => $event');
      },
      onDone: () => print('Stream*2 Done!!!'),
      onError: (error) => print('Stream*2  Error $error'),
    );

    print('Esta es la contiuacion del codigo initState...');
    // streamController.add(
    //     '**Esto es un evendo agregado directamente, para ambos Listen *1*2 **');
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
    print("Fetched Data, despues de 5 segundos...");
    await Future.delayed(Duration(milliseconds: 5000));
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
                  Route route =
                      MaterialPageRoute(builder: (context) => Page2());
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
