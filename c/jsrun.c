#include <emscripten.h>
#include <stdio.h>

int js_run(char *script) {
    emscripten_run_script(script);
    return 0;
}

EM_JS(void, set_square_pos, (char* selectorPtr), {
    const selector = Module.UTF8ToString(selectorPtr);
    document.querySelector(selector).style.left = window.lastPressed + "px";
});

int js_run_async(char *script) {
    emscripten_async_run_script(script, 10);
    return 0;
}