function degToRad(c) {
    return (c * Math.PI) / 180.0;
};
function radToDeg(c) {
    return (c * 180.0) / Math.PI;
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
function angleBetweenPoints(first, second) {
    var diff = pointSubtract(second, first);
    return atan2(diff.x, diff.y);
};
function pointSnap(p, sz) {
    return { x : Math.round(p.x / sz) * sz, y : Math.round(p.y / sz) * sz };
};
function randomSigned() {
    return Math.random() * 2 - 1;
};
function randomInRange(min, max) {
    return min + randam() * (max - min);
};
function randomPointInRect(r) {
    return { x : randomInRange(r.origin.x, r.origin.x + r.size.width), y : randomInRange(r.origin.y, r.origin.y + r.size.height) };
};
function randomPointInCircle(c) {
    var p = pointNormal({ x : randomSigned(), y : randomSigned() });
    return pointAdd({ x : p.x * c.radius, y : p.y * c.radius }, c.origin);
};
function randomArrayElement(arr) {
    return arr.randomInRange(0, arr.length);
};
function keepPointInRect(p, r) {
    return { x : p.x < r.origin.x ? r.origin.x : (p.x >= r.origin.x + r.size.width ? r.origin.x + r.size.width : p.x), y : p.y < r.origin.y ? r.origin.y : (p.y >= r.origin.y + r.size.height ? r.origin.y + r.size.height : p.y) };
};