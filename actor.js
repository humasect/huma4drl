function Actor(name, char, x, y) {
    return { name : name, pos : pointMake(x, y), 'char' : char };
};
function actorRender(a) {
    cgFillStyle('yellow');
    return CTX.fillText(a['char'], pointScrX(a.pos), pointScrY(a.pos));
};
function actorMove(a, angle) {
    var by = pointRotate(pointMake(0, -1), degToRad(angle));
    var to = pointAdd(a.pos, pointSnap(by, 1));
    return a.pos = keepPointInRect(to, SCREEN.bounds);
};