var SCREENWIDTH = SCREENWIDTH;
var SCREENHEIGHT = SCREENHEIGHT;
var CTX = null;
var SCREEN = null;
function startGraph() {
    CTX = $('#screen_canvas')[0].getContext('2d');
    CTX.font = 32 + 'px ' + 'helvetica';
    SCREEN = { name : '*screen*', superlayer : null, sublayers : [], bounds : { origin : { x : 0, y : 0 }, size : { width : SCREENWIDTH, height : SCREENHEIGHT } }, fillStyle : 'blue', strokeStyle : 'white' };
    return startMain();
};
$(document).ready(startGraph);