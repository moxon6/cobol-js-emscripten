#include <emscripten.h>

EM_JS(void, set_asyncify_stack_size, (int size), {
  Asyncify.StackSize = size;
});

int boost_stack_size() {
    set_asyncify_stack_size(512 * 1024);
    return 0;
}

int updateDOM() {
    emscripten_sleep(10);
    return 0;
}

int jsRun() {
    emscripten_run_script("alert('llama')");
    return 0;
}

int domSleep() {
    // emscripten_sleep(1000);
    return 0;
}
