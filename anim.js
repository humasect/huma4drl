function Layer(n, x, y, w, h) {
    return { name : n, superlayer : null, sublayers : [], bounds : rectMake(x, y, w, h), fillStyle : 'blue', strokeStyle : 'white' };
};
function layerAddSublayer(l, s) {
    return l.sublayers.concat([s]);
};
function layerRender(l) {
    console.log(l.bounds);
    CTX.fillStyle = l.fillStyle;
    CTX.strokeStyle = l.strokeStyle;
    fillRect(l.bounds);
    for (var s in l.sublayers) {
        layerRender(s);
    };
};