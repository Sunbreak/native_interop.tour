import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:native_interop/native_interop.dart';

void main() {
  ensureNativeInitialized();
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
        body: Column(
          children: [
            RaisedButton(
              child: Text('nativeAdd'),
              onPressed: () {
                print('nativeAdd(1, 2) = ${nativeAdd(1, 2)}');
              },
            ),
            RaisedButton(
              child: Text('nativeSyncCallback'),
              onPressed: () {
                var normalFunc = Pointer.fromFunction<NativeSyncCallbackFunc>(normalSyncCallback, syncExceptionalReturn);
                nativeSyncCallback(normalFunc);

                var exceptionalFunc = Pointer.fromFunction<NativeSyncCallbackFunc>(exceptionalSyncCallback, syncExceptionalReturn);
                nativeSyncCallback(exceptionalFunc);
              },
            ),
            RaisedButton(
              child: Text('nativeAsyncCallback'),
              onPressed: () {
                var asyncFunc = Pointer.fromFunction<NativeAsyncCallbackFunc>(asyncCallback);
                nativeAsyncCallback(asyncFunc);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Should be constant
const syncExceptionalReturn = -1;

// Should be top level function
int normalSyncCallback(int n) {
  print('normalSyncCallback called');
  return n * n;
}

int exceptionalSyncCallback(int n) {
  print('exceptionalSyncCallback called');
  return n ~/ 0;
}

/* ---------------------------------------------------------------- */

void asyncCallback() {
  print('asyncCallback called');
}