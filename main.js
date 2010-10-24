var TILEWIDTH = 32;
var TILEHEIGHT = 32;
var SCRWIDTH = 32;
var SCRHEIGHT = 24;
var CTX = null;
function clog(msg) {
    var args = [];
    for (var i9 = 0; i9 < arguments.length - 1; i9 += 1) {
        args[i9] = arguments[i9 + 1];
    };
    return console.log(msg + args);
};
function modX(x) {
    return x * TILEWIDTH;
};
function modY(y) {
    return y * TILEHEIGHT;
};
function fillStyle(style) {
    return CTX.fillStyle = style;
};
function fillRect(x, y, w, h) {
    return CTX.fillRect(modX(x), modY(y), modX(w), modY(h));
};
function clear() {
    fillStyle('rgb(0,0,0)');
    return fillRect(0, 0, SCRWIDTH, SCRHEIGHT);
};
function redraw() {
    return clear();
};
function startGame() {
    CTX = $('#canvas')[0].getContext('2d');
    return redraw();
};
function gameTurn(angle) {
    clog('take a turn');
    return redraw();
};
$(document).ready(startGame);
document.onkeydown = function (e) {
    var angleMap = { 'd' : 270, 'b' : 180, 'f' : 90, 'h' : 0, 'g' : 315, 'i' : 45, 'c' : 135, 'a' : 225 };
    var s = String.fromCharCode(e.which || e.keyCode);
    var a = angleMap[s];
    if (undefined == a) {
        return clog('unknown key: ', s);
    } else {
        return gameTurn(a);
    };
};