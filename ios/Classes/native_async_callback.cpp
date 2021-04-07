// C
#include <stdio.h>

// Unix
#include <pthread.h>

#ifdef __cplusplus
extern "C" {
#endif

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

__attribute__((visibility("default"))) __attribute__((used))
void NativeAsyncCallback(VoidCallbackFunc callback) {
    pthread_t local_thread;
    pthread_create(&local_thread, NULL, thread_func, (void *)local_callback);

    // pthread_t callback_thread;
    // pthread_create(&callback_thread, NULL, thread_func, (void *)callback);
}

#ifdef __cplusplus
}
#endif