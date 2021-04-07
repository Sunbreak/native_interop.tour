import 'dart:ffi';
import 'dart:io';

final DynamicLibrary nativeInteropLib = Platform.isAndroid
    ? DynamicLibrary.open("libnative_interop.so")
    : DynamicLibrary.process();

final int Function(int x, int y) nativeAdd = nativeInteropLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add")
    .asFunction();