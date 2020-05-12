#include <emscripten.h>

EM_JS(int, set_asyncify_stack_size, (), {
  Asyncify.StackSize = 512 * 1024;
  Module.quit = () => null;
  window.onkeydown = e => {
    window.lastPressed = e.code;
  };
  window.prompt = () => { 
     
    if(!window.hasEntered) { 
      window.hasEntered = true;
      return window.lastPressed;
    } else { 
      window.hasEntered = false; 
      window.lastPressed = "";
      return null; 
    }
  }
});

int startup() {
    return set_asyncify_stack_size();
}