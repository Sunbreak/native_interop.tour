import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/widgets.dart';

final DynamicLibrary nativeInteropLib = Platform.isAndroid
    ? DynamicLibrary.open("libnative_interop.so")
    : DynamicLibrary.process();

final int Function(int x, int y) nativeAdd = nativeInteropLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add")
    .asFunction();

/* ---------------------------------------------------------------- */

typedef NativeSyncCallbackFunc = Int32 Function(Int32 n);

typedef _c_NativeSyncCallback = Void Function(
  Pointer<NativeFunction<NativeSyncCallbackFunc>> callback,
);

typedef _dart_NativeSyncCallback = void Function(
  Pointer<NativeFunction<NativeSyncCallbackFunc>> callback,
);

final _dart_NativeSyncCallback nativeSyncCallback = nativeInteropLib
    .lookup<NativeFunction<_c_NativeSyncCallback>>("NativeSyncCallback")
    .asFunction();

/* ---------------------------------------------------------------- */

final _initializeApi = nativeInteropLib.lookupFunction<
    IntPtr Function(Pointer<Void>),
    int Function(Pointer<Void>)>("InitDartApiDL");

ReceivePort _receivePort;
StreamSubscription _subscription;

void ensureNativeInitialized() {
  if (_receivePort == null) {
    WidgetsFlutterBinding.ensureInitialized();
    var nativeInited = _initializeApi(NativeApi.initializeApiDLData);
    // According to https://dart-review.googlesource.com/c/sdk/+/151525
    // flutter-1.24.0-10.1.pre+ has `DART_API_DL_MAJOR_VERSION = 2`
    assert(nativeInited == 0, 'DART_API_DL_MAJOR_VERSION != 2');
    _receivePort = ReceivePort();
    _subscription = _receivePort.listen(_handleNativeMessage);
    _registerSendPort(_receivePort.sendPort.nativePort);
  }
}

void dispose() {
  // TODO _unregisterReceivePort(_receivePort.sendPort.nativePort);
  _subscription?.cancel();
  _receivePort?.close();
}

final _registerSendPort = nativeInteropLib.lookupFunction<
    Void Function(Int64 sendPort),
    void Function(int sendPort)>('RegisterSendPort');

void _handleNativeMessage(dynamic message) {
  print('_handleNativeMessage $message');
  final int address = message;
  _executeCallback(Pointer<Void>.fromAddress(address).cast());
}

typedef NativeAsyncCallbackFunc = Void Function();

typedef _c_NativeAsyncCallback = Void Function(
  Pointer<NativeFunction<NativeAsyncCallbackFunc>> callback,
);

typedef _dart_NativeAsyncCallback = void Function(
  Pointer<NativeFunction<NativeAsyncCallbackFunc>> callback,
);

final _dart_NativeAsyncCallback nativeAsyncCallback = nativeInteropLib
    .lookup<NativeFunction<_c_NativeAsyncCallback>>("NativeAsyncCallback")
    .asFunction();

final _executeCallback = nativeInteropLib.lookupFunction<_c_NativeAsyncCallback,
    _dart_NativeAsyncCallback>('ExecuteCallback');
