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
    var x105 = r.origin.x;
    var y106 = r.origin.y;
    var w = r.size.width;
    var h = r.size.height;
    return CTX.fillRect(modX(x105), modY(y106), modX(w), modY(h));
};
function clear() {
    fillStyle('rgb(0,0,0)');
    return fillRect(rectMake(0, 0, SCRWIDTH, SCRHEIGHT));
};
function redraw() {
    clear();
    layerRender(SCREEN);
    for (var i in WORLD.actors) {
        actorRender(WORLD.actors[i]);
    };
};
function startGame() {
    CTX = $('#canvas')[0].getContext('2d');
    CTX.font = 32 + 'px ' + 'helvetica';
    SCREEN = Layer('world', 0, 0, SCRWIDTH, SCRHEIGHT);
    var left = Layer('test', 5, 10, 5, 5);
    left.fillStyle = 'red';
    layerAddSublayer(SCREEN, left);
    var right = Layer('test', 20, 10, 5, 5);
    right.fillStyle = 'green';
    layerAddSublayer(SCREEN, right);
    console.log(SCREEN);
    var player = Actor('Player', '@', 2, 2);
    var monster = Actor('Monster', 'M', 10, 10);
    WORLD = { actors : [player, monster] };
    console.log(WORLD);
    return redraw();
};
function actorNamed(name) {
    var found = null;
    for (var i in WORLD.actors) {
        (function (a) {
            if (a.name == name) {
                return found = a;
            };
        })(WORLD.actors[i]);
    };
    return found;
};
function gameTurn(angle) {
    console.log('take a turn, angle: ' + angle);
    actorMove(actorNamed('Player'), angle);
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