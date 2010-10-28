function layerAddSublayer(l, s) {
    l.sublayers.push(s);
    return s.parent = l;
};
function layerRender(l) {
    CTX.fillStyle = l.fillStyle;
    CTX.strokeStyle = l.strokeStyle;
    CTX.fillRect(l.bounds.origin.x, l.bounds.origin.y, l.bounds.size.width, l.bounds.size.height);
    for (var i in l.sublayers) {
        layerRender(l.sublayers[i]);
    };
};