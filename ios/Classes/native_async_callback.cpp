// C
#include <stdio.h>

// Unix
#include <pthread.h>

#include "dart_api/dart_api.h"

typedef void (*VoidCallbackFunc)();

void *thread_func(void *args) {
    VoidCallbackFunc callback = (VoidCallbackFunc) args;
    printf("(%p) is called on (%p)\n", callback, pthread_self());
    callback();
    pthread_exit(args);
}

void local_callback() {
    printf("local_callback called\n");
}

DART_EXPORT void NativeAsyncCallback(VoidCallbackFunc callback) {
    pthread_t local_thread;
    pthread_create(&local_thread, NULL, thread_func, (void *)local_callback);

    /* Cannot invoke native callback outside an isolate. Check https://github.com/dart-lang/sdk/issues/37022 */
    // pthread_t callback_thread;
    // pthread_create(&callback_thread, NULL, thread_func, (void *)callback);
}