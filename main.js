var TILESIZE = sizeMake(32, 32);
var SCREENSIZE = sizeMake(32, 24);
var CTX = null;
var SCREEN = null;
var WORLD = null;
var TILEWIDTH = 32;
var TILEHEIGHT = 32;
var SCRWIDTH = 32;
var SCRHEIGHT = 24;
function modX(x) {
    return x * TILEWIDTH;
};
function modY(y) {
    return y * TILEHEIGHT;
};
function fillStyle(style) {
    return CTX.fillStyle = style;
};
function fillRect(r) {
    var x71 = r.origin.x;
    var y72 = r.origin.y;
    var w = r.size.width;
    var h = r.size.height;
    return CTX.fillRect(modX(x71), modY(y72), modX(w), modY(h));
};
function clear() {
    fillStyle('rgb(0,0,0)');
    return fillRect(rectMake(0, 0, SCRWIDTH, SCRHEIGHT));
};
function redraw() {
    clear();
    layerRender(SCREEN);
    var __array = WORLD.actors;
    for (var i in __array) {
        actorRender(__array[i]);
    };
};
function startGame() {
    CTX = $('#canvas')[0].getContext('2d');
    SCREEN = Layer('world', 0, 0, SCRWIDTH, SCRHEIGHT);
    layerAddSublayer(SCREEN, Layer('test', 10, 10, 10, 10));
    console.log(SCREEN);
    var player = Actor('Player', '@', 32, 32);
    var monster = Actor('Monster', 'M', 100, 80);
    WORLD = { actors : [player, monster] };
    console.log(WORLD);
    return redraw();
};
function gameTurn(angle) {
    console.log('take a turn, angle: ' + angle);
    return redraw();
};
$(document).ready(startGame);
document.onkeydown = function (e) {
    var angleMap = { 'd' : 270, 'b' : 180, 'f' : 90, 'h' : 0, 'g' : 315, 'i' : 45, 'c' : 135, 'a' : 225 };
    var s = String.fromCharCode(e.which || e.keyCode);
    var a = angleMap[s];
    if (undefined == a) {
        return console.log('unknown key: ' + s);
    } else {
        return gameTurn(a);
    };
};