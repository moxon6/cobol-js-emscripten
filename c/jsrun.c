#include <emscripten.h>
#include <stdio.h>

int updateDOM() {
    emscripten_sleep(10);
    return 0;
}

int jsRun(char *hello) {
    emscripten_run_script("console.log('llama')");
    return 0;
}

int domSleep() {
    emscripten_sleep(1000);
    return 0;
}
