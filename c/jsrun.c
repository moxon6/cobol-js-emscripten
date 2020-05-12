#include <emscripten.h>
#include <stdio.h>

int js_run(char *script) {
    emscripten_run_script(script);
    return 0;
}

EM_JS(void, set_square_pos, (char* selectorPtr, char* leftPositionPtr), {
    const selector = Module.UTF8ToString(selectorPtr);
    const leftPosition = Module.UTF8ToString(leftPositionPtr);
    document.querySelector(selector).style.left = leftPosition + "px";
});

int js_run_async(char *script) {
    emscripten_async_run_script(script, 10);
    return 0;
}