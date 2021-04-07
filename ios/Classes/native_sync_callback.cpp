#include <iostream>

#ifdef __cplusplus
extern "C" {
#endif

typedef int32_t (*CallbackFunc)(int32_t n);

__attribute__((visibility("default"))) __attribute__((used))
void NativeSyncCallback(CallbackFunc callback) {
    std::cout << "NativeSyncCallback callback(9) = " << callback(9) << std::endl; // XCode debug print
}

#ifdef __cplusplus
}
#endif