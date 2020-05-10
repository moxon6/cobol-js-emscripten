#include <emscripten.h>

int updateDOM() {
    emscripten_sleep(0);
}

int jsrun(char *hello) {
    emscripten_run_script(hello);
}

int domSleep() {
    emscripten_sleep(100);
}