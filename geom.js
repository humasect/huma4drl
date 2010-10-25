function degToRad(c) {
    return (c * Math.PI) / 180.0;
};
function radToDeg(c) {
    return (c * 180.0) / Math.PI;
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
    var st = Math.sin(te);
    return { x : ct * p.x - st * p.y, y : st * p.x + ct * p.y };
};
function pointAngleBetween(first, second) {
    var diff = pointSubtract(second, first);
    return atan2(diff.x, diff.y);
};
function pointSnap(p, sz) {
    return { x : Math.round(p.x / sz) * sz, y : Math.round(p.y / sz) * sz };
};
function sizeMake(w, h) {
    return { width : w, height : h };
};
function rectMake(x, y, w, h) {
    return { origin : { x : x, y : y }, size : sizeMake(w, h) };
};
function rectMinX(r) {
    return r.origin.x;
};
function rectMinY(r) {
    return r.origin.y;
};
function rectMaxX(r) {
    return r.origin.x + size.width;
};
function rectMaxY(r) {
    return r.origin.y + size.height;
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
    var p = pointNormal({ x : randomSigned(), y : randomSigned() });
    return pointAdd(pointScale(p, radius), { x : x, y : y });
};