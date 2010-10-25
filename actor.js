function Actor(name, char, x, y) {
    return { name : name, pos : { x : x, y : y }, 'char' : char };
};
function actorRender(a) {
    CTX.fillStyle = 'yellow';
    return CTX.fillText(a['char'], a.pos.x * TILEWIDTH, a.pos.y * TILEHEIGHT);
};
function actorMove(a, angle) {
    var by = pointRotate({ x : 0, y : -1 }, degToRad(angle));
    var to = pointAdd(a.pos, pointSnap(by, 1));
    a.pos = to;
    return console.log('position = ' + to);
};