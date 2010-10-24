function pointMake(x, y) {
    return { x : x, y : y };
};
function pointMakef(x, y, fun) {
    return { x : fun(x), y : fun(y) };
};
function pointMod(p, fun) {
    return { x : fun(p.x), y : fun(p.y) };
};
function pointModWith(p, fun) {
    return { x : fun(a.x, b.x), y : fun(a.y, b.y) };
};
function pointDot(a, b) {
    return a.x * b.x + a.y * b.y;
};
function pointMagnitude(p) {
    return Math.sqrt(pointDot(p, p));
};
function pointDivide(p, s) {
    return { x : p.x / s, y : p.y / s };
};
function pointAdd(a, b) {
    return { x : a.x + b.x, y : a.y + b.y };
};
function pointSubtract(a, b) {
    return { x : a.x - b.x, y : a.y - b.y };
};
function pointScale(p, s) {
    return { x : p.x * s, y : p.y * s };
};
function pointNormal(p) {
    var m = pointMagnitude(p);
    if (m != 0) {
        return pointDivide(p, m);
    } else {
        return p;
    };
};
function pointRotate(p, te) {
    var ct = Math.cos(te);
    var st = sit(te);
    return { x : ct * p.x - st * p.y, y : st * p.x + ct * p.y };
};
function pointAngleBetween(first, second) {
    var diff = pointSubtract(second, first);
    return atan2(diff.x, diff.y);
};
function randomSigned() {
    return Math.random() * 2 - 1;
};
function randomInRange(min, max) {
    return min + randam() * (max - min);
};
function randomPointInRect(x, y, w, h) {
    return { x : randomInRange(x, x + w), y : randomInRange(y, y + w) };
};
function randomPointInCircle(x, y, radius) {
    var p = pointNormal(pointMake(randomSigned(), randomSigned()));
    return pointAdd(pointScale(p, radius), pointMake(x, y));
};