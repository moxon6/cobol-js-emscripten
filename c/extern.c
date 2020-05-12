#include <emscripten.h>
#include <stdio.h>

EM_JS(void, set_square_pos, (char* selectorPtr, char* leftPositionPtr), {
    const selector = Module.UTF8ToString(selectorPtr);
    const leftPosition = Module.UTF8ToString(leftPositionPtr);
    document.querySelector(selector).style.left = leftPosition + "px";
});

EM_JS(void, startup, (), {
  Asyncify.StackSize = 512 * 1024;
  window.onkeydown = e => window.lastPressed = e.code;
  
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
