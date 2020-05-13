let unhandled = [];

const keysDown = {};
window.onkeydown = e => keysDown[e.code] = true;
window.onkeyup = e => keysDown[e.code] = false;

const getKeysDown = () => Object.keys(keysDown)
    .filter(key => keysDown[key]);

// Alternates between evaluating the input function and returning null
const alternator = {
    sendFunction: true,
    handle (fn, shoudEvaluateFunction = this.shoudEvaluateFunction) {
        this.shoudEvaluateFunction = !shoudEvaluateFunction;
        return shoudEvaluateFunction ? fn() : null;
    }    
}

window.prompt = () => alternator.handle(() => {
    if (!unhandled.length) {
        unhandled = getKeysDown();
        return ""
    }
    return unhandled.shift();
});

function setElementProperty(selector, prop, value) {
    const element = document.querySelector(selector);
    if (_.get(element, prop) !== value) {
        _.set(element, prop, value)
    }
}