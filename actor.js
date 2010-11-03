function actorMove(a, angle) {
    var by = pointRotate({ x : 0, y : -1 }, degToRad(angle));
    var to = pointAdd(a.bounds.origin, pointSnap(by, 1));
    return a.bounds.origin = keepPointInRect(to, SCREEN.bounds);
};