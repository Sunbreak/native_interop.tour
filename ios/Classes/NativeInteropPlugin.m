#import "NativeInteropPlugin.h"
#if __has_include(<native_interop/native_interop-Swift.h>)
#import <native_interop/native_interop-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "native_interop-Swift.h"
#endif

@implementation NativeInteropPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNativeInteropPlugin registerWithRegistrar:registrar];
}
@end
