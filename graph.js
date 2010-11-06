var SCREENWIDTH = 32;
var SCREENHEIGHT = 24;
var CTX = null;
var SCREEN = null;
function cgShadowOffset(p) {
    CTX.shadowOffsetX = p.x;
    CTX.shadowOffsetY = p.y;
    return null;
};
function startGraph() {
    CTX = $('#screen-canvas')[0].getContext('2d');
    CTX.font = 32 + 'px ' + 'helvetica';
    SCREEN = { name : '*screen*', superlayer : null, sublayers : [], parent : null, bounds : { origin : { x : 0, y : 0 }, size : { width : SCREENWIDTH, height : SCREENHEIGHT } }, fillStyle : 'black', strokeStyle : 'white', contents : null, render : null, animations : [] };
    return startMain();
};
$(document).ready(startGraph);