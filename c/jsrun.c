#include <emscripten.h>
#include <stdio.h>

int js_run(char *script) {
    emscripten_run_script(script);
    return 0;
}
int js_run_async(char *script) {
    emscripten_async_run_script(script, 10);
    return 0;
}

int testfunc(char* input) {
    printf("%s", input);
    printf("\n");
    return 0;
}