import 'dart:ffi';
import 'dart:io';

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