#include <emscripten.h>
#include <stdlib.h>
#include <stdio.h>

int domUpdate() {
    emscripten_sleep(10);
    return 0;
}

int em_sleep(char *duration) {
    emscripten_sleep(atoi(duration));
    return 0;
}
