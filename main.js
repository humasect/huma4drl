var TILEWIDTH = 32;
var TILEHEIGHT = 32;
var SCREENWIDTH = 32;
var SCREENHEIGHT = 24;
var CTX = null;
var SCREEN = null;
var WORLD = null;
function clear() {
    CTX.fillStyle = 'rgb(0,0,0)';
    return CTX.fillRect(SCREEN.bounds.origin.x * TILEWIDTH, SCREEN.bounds.origin.y * TILEHEIGHT, SCREEN.bounds.size.width * TILEWIDTH, SCREEN.bounds.size.height * TILEHEIGHT);
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
    SCREEN = { name : 'World', superlayer : null, sublayers : [], bounds : { origin : { x : 0, y : 0 }, size : { width : 32, height : 24 } }, fillStyle : 'blue', strokeStyle : 'white' };
    layerAddSublayer(SCREEN, { name : 'test-left', superlayer : null, sublayers : [], bounds : { origin : { x : 5, y : 10 }, size : { width : 5, height : 5 } }, fillStyle : 'red', strokeStyle : 'white' });
    layerAddSublayer(SCREEN, { name : 'test-right', superlayer : null, sublayers : [], bounds : { origin : { x : 20, y : 10 }, size : { width : 5, height : 5 } }, fillStyle : 'green', strokeStyle : 'white' });
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