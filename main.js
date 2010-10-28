var TILEWIDTH = 32;
var TILEHEIGHT = 32;
var WORLD = null;
function startMain() {
    layerAddSublayer(SCREEN, newLayer('name', 'test-left', 'fill-style', 'red', 'bounds', rectMake(5, 10, 5, 5)));
    layerAddSublayer(SCREEN, newLayer('name', 'test-right', 'fill-style', 'green', 'bounds', rectMake(20, 10, 5, 5)));
    console.log(SCREEN);
    SCREEN.fillStyle = 'blue';
    layerRender(SCREEN);
    var player = Actor('Player', '@', 2, 2);
    var monster = Actor('Monster', 'M', 10, 10);
    WORLD = { actors : [player, monster] };
    console.log(WORLD);
    for (var i in WORLD.actors) {
        actorRender(WORLD.actors[i]);
    };
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