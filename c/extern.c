#include <emscripten.h>
#include <stdio.h>

EM_JS(void, set_element_property, (char* selectorPtr, char* stylePropPtr, char* styleValuePtr), {
    const selector = Module.UTF8ToString(selectorPtr);
    const styleProp = Module.UTF8ToString(stylePropPtr);
    const styleValue = Module.UTF8ToString(styleValuePtr);

    const { style } = document.querySelector(selector);
    if (style[styleProp] !== styleValue) {
      style[styleProp] = styleValue;
    }
});

EM_JS(void, startup, (), {
  Asyncify.StackSize = 512 * 1024;
  });
