function layerAddSublayer(l, s) {
    l.sublayers.push(s);
    return s.parent = l;
};
function layerRender(l) {
    CTX.fillStyle = l.fillStyle;
    CTX.strokeStyle = l.strokeStyle;
    CTX.fillRect(l.bounds.origin.x * TILEWIDTH, l.bounds.origin.y * TILEHEIGHT, l.bounds.size.width * TILEWIDTH, l.bounds.size.height * TILEHEIGHT);
    for (var i in l.sublayers) {
        layerRender(l.sublayers[i]);
    };
};