#include <emscripten.h>

EM_JS(int, set_asyncify_stack_size, (), {
  Asyncify.StackSize = 512 * 1024;
  return 0;
});

int startup() {
    return set_asyncify_stack_size();
}