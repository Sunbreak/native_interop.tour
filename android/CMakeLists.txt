cmake_minimum_required(VERSION 3.4.1)  # for example

add_library(native_interop
            # Sets the library as a shared library.
            SHARED
            # Provides a relative path to your source file(s).
            ../ios/Classes/native_add.c
            ../ios/Classes/native_sync_callback.cpp
            ../ios/Classes/native_async_callback.cpp)