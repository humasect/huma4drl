function layerAddSublayer(l, s) {
    l.sublayers.push(s);
    return s.parent = l;
};
function sublayerNamed(l, name) {
    var found = null;
    for (var __i in l.sublayers) {
        var s = l.sublayers[__i];
        if (s.name == name) {
            found = s;
        };
    };
    return found;
};
function layerRender(l) {
    if (l.contents != 'empty') {
        CTX.fillStyle = l.fillStyle;
        CTX.strokeStyle = l.strokeStyle;
        if (l.render) {
            l.render();
        } else {
            var bounds2 = { origin : { x : l.bounds.origin.x * 32, y : l.bounds.origin.y * 32 }, size : { width : l.bounds.size.width * 32, height : l.bounds.size.height * 32 } };
            if (typeof l.contents == 'string') {
                CTX.fillText(l.contents, bounds2.origin.x, bounds2.origin.y);
            } else {
                CTX.fillRect(bounds2.origin.x, bounds2.origin.y, bounds2.size.width, bounds2.size.height);
            };
        };
    };
    for (var __i in l.sublayers) {
        var s = l.sublayers[__i];
        layerRender(s);
    };
};