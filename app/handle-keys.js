const keysDown = {};
let sendFunction = true;
let unhandled = [];

window.onkeydown = e => keysDown[e.code] = true;
window.onkeyup = e => keysDown[e.code] = false;

const getKeysDown = () => Object.keys(keysDown)
    .filter(key => keysDown[key]);

function alternate(fn) {
    // Alternates between evaluating the input function and returning null
    const returnValue = sendFunction ? fn() : null;
    sendFunction = !sendFunction;
    return returnValue;
}

window.prompt = () => alternate(() => {
    if (!unhandled.length) {
        unhandled = getKeysDown();
        return ""
    }
    return unhandled.shift();
});