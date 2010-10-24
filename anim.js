point = { makef : function (x, y, fun) {
    return { x : fun(x), y : fun(y) };
}, mod : function (p, fun) {
    return { x : fun(p.x), y : fun(p.y) };
}, modWith : function (a, b, fun) {
    return { x : fun(a.x, b.x), y : fun(a.y, b.y) };
}, dot : function (a, b) {
    return a.x * b.x + a.y * b.y;
}, magnitude : function (p) {
    return Math.sqrt(point.dot(p, p));
}, divide : function (a, s) {
    return { x : a.x / s, y : a.y / s };
}, add : function (a, b) {
    return { x : a.x + b.x, y : a.y + b.y };
}, subtract : function (a, b) {
    return { x : a.x - b.x, y : a.y - b.y };
}, scale : function (p, s) {
    return { x : p.x * s, y : p.y * s };
} };
function newLayer(n) {
    return { name : n, superlayer : null, sublayers : [], origin : [0, 0], size : [0, 0] };
};