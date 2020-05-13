let unhandled = [];

const keysDown = {};
window.onkeydown = e => keysDown[e.code] = true;
window.onkeyup = e => keysDown[e.code] = false;

const getKeysDown = () => Object.keys(keysDown)
    .filter(key => keysDown[key]);

// Alternates between evaluating the input function and returning null
const alternator = {
    sendFunction: true,
    handle (fn, sendFunction = this.sendFunction) {
        this.sendFunction = !sendFunction;
        return sendFunction ? fn() : null;
    }    
}

window.prompt = () => alternator.handle(() => {
    if (!unhandled.length) {
        unhandled = getKeysDown();
        return ""
    }
    return unhandled.shift();
});

function setElementProperty(selector, styleProp, styleValue) {
    const { style } = document.querySelector(selector);
    if (style[styleProp] !== styleValue) {
        style[styleProp] = styleValue;
    }
}