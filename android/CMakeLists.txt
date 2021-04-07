cmake_minimum_required(VERSION 3.4.1)  # for example

add_library(native_interop
            # Sets the library as a shared library.
            SHARED
            # Provides a relative path to your source file(s).
            ../ios/Classes/dart_api/dart_api.h
            ../ios/Classes/dart_api/dart_api_dl.h
            ../ios/Classes/dart_api/dart_native_api.h
            ../ios/Classes/dart_api/dart_version.h
            ../ios/Classes/dart_api/internal/dart_api_dl_impl.h
            ../ios/Classes/dart_api/dart_api_dl.c
            ../ios/Classes/native_add.c
            ../ios/Classes/native_sync_callback.cpp
            ../ios/Classes/native_async_callback.cpp)