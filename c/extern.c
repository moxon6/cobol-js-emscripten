#include <emscripten.h>
#include <stdio.h>

EM_JS(void, set_element_property, (char* selectorPtr, char* stylePropPtr, char* styleValuePtr), {
    setElementProperty(...[...arguments].map(x => Module.UTF8ToString(x)));
});

EM_JS(void, startup, (), {
  Asyncify.StackSize = 512 * 1024;
  });
