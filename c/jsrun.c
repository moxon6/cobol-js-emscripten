#include <emscripten.h>

int js_run(char *script) {
    emscripten_run_script(script);
    return 0;
}

