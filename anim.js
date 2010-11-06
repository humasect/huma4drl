var ANIMINTERVAL = null;
function animStart() {
    return ANIMINTERVAL = setInterval(animLoop, 1000 / 30);
};
function animStop() {
    clearInterval(ANIMINTERVAL);
    return ANIMINTERVAL = null;
};
function animLoop() {
    return function moveLayer(l) {
        return null;
    };
};