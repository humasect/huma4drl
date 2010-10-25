function Layer(n, x, y, w, h) {
    return { name : n, superlayer : null, sublayers : [], bounds : rectMake(x, y, w, h), fillStyle : 'blue', strokeStyle : 'white' };
};
function layerAddSublayer(l, s) {
    console.log(s);
    return l.sublayers.push(s);
};
function layerRender(l) {
    CTX.fillStyle = l.fillStyle;
    CTX.strokeStyle = l.strokeStyle;
    fillRect(l.bounds);
    var __array = l.sublayers;
    for (var i in __array) {
        layerRender(__array[i]);
    };
};