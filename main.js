var PIECES = null;
var ACTORS = null;
function redraw() {
    return layerRender(SCREEN);
};
function startMain() {
    PIECES = { name : '*pieces*', superlayer : null, sublayers : [], parent : null, bounds : { origin : { x : 0, y : 0 }, size : { width : 1, height : 1 } }, fillStyle : 'black', strokeStyle : 'white', contents : 'empty', render : null };
    layerAddSublayer(SCREEN, PIECES);
    for (var __i in [{ name : 'test-left', superlayer : null, sublayers : [], parent : null, bounds : { origin : { x : 5, y : 10 }, size : { width : 5, height : 5 } }, fillStyle : 'red', strokeStyle : 'white', contents : null, render : null }, { name : 'test-right', superlayer : null, sublayers : [], parent : null, bounds : { origin : { x : 20, y : 10 }, size : { width : 5, height : 5 } }, fillStyle : 'green', strokeStyle : 'white', contents : null, render : null }]) {
        var s = [{ name : 'test-left', superlayer : null, sublayers : [], parent : null, bounds : { origin : { x : 5, y : 10 }, size : { width : 5, height : 5 } }, fillStyle : 'red', strokeStyle : 'white', contents : null, render : null }, { name : 'test-right', superlayer : null, sublayers : [], parent : null, bounds : { origin : { x : 20, y : 10 }, size : { width : 5, height : 5 } }, fillStyle : 'green', strokeStyle : 'white', contents : null, render : null }][__i];
        layerAddSublayer(PIECES, s);
    };
    ACTORS = { name : '*actors*', superlayer : null, sublayers : [], parent : null, bounds : { origin : { x : 0, y : 0 }, size : { width : 1, height : 1 } }, fillStyle : 'black', strokeStyle : 'white', contents : 'empty', render : null };
    layerAddSublayer(SCREEN, ACTORS);
    for (var __i in [{ name : 'Player', superlayer : null, sublayers : [], parent : null, bounds : { origin : { x : 2, y : 2 }, size : { width : 1, height : 1 } }, fillStyle : 'yellow', strokeStyle : 'white', contents : '@', render : null }, { name : 'Monster', superlayer : null, sublayers : [], parent : null, bounds : { origin : { x : 10, y : 10 }, size : { width : 1, height : 1 } }, fillStyle : 'yellow', strokeStyle : 'white', contents : 'M', render : null }]) {
        var s = [{ name : 'Player', superlayer : null, sublayers : [], parent : null, bounds : { origin : { x : 2, y : 2 }, size : { width : 1, height : 1 } }, fillStyle : 'yellow', strokeStyle : 'white', contents : '@', render : null }, { name : 'Monster', superlayer : null, sublayers : [], parent : null, bounds : { origin : { x : 10, y : 10 }, size : { width : 1, height : 1 } }, fillStyle : 'yellow', strokeStyle : 'white', contents : 'M', render : null }][__i];
        layerAddSublayer(ACTORS, s);
    };
    SCREEN.fillStyle = 'blue';
    console.log(SCREEN);
    return redraw();
};
function gameTurn(angle) {
    actorMove(sublayerNamed(ACTORS, 'Player'), angle);
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