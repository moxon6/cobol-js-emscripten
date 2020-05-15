let inputStream = []

const keysDown = {};
window.onkeydown = e => keysDown[e.code] = true;
window.onkeyup = e => keysDown[e.code] = false;

const getKeysDown = () => Object.keys(keysDown)
    .filter(key => keysDown[key]);

// Final empty string denotes end of series of keys
const mapKeysToNullTerminatedInputSequence = strings => ([...strings, ""])
    .map(str => [str, null]) // Adding nulls to terminate strings going to stdin
    .flat()

const getInputStream = () => mapKeysToNullTerminatedInputSequence(getKeysDown())

window.prompt = () => {
    if (!inputStream.length) inputStream = getInputStream()
    return inputStream.shift();
}

function _setElementProperty(selector, prop, value) {
    const element = document.querySelector(selector);
    
    let obj = element
    const path = prop.split(".")

    while (path.length > 1) obj = obj[path.shift()]
    obj[path[0]] = value;
}