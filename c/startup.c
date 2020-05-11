#include <emscripten.h>

EM_JS(void, set_asyncify_stack_size, (int size), {
  Asyncify.StackSize = size;
});

int startup() {
    set_asyncify_stack_size(512 * 1024);
    return 0;
}