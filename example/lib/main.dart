import 'package:flutter/material.dart';

import 'package:native_interop/native_interop.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('nativeAdd(1, 2) = ${nativeAdd(1, 2)}'),
        ),
      ),
    );
  }
}
