var TILEWIDTH = 24;
var TILEHEIGHT = 30;
var MAPWIDTH = 32;
var MAPHEIGHT = 24;
function forEachTileXy(Fun) {
    for (var i = 0; i <= MAPWIDTH; i += 1) {
        for (var j = 0; j <= MAPHEIGHT; j += 1) {
            Fun(i, j);
        };
        null;
    };
    return null;
};
function createMap() {
    return forEachTileXy(function (x, y) {
        return $('#view').append('<div></div>');
    });
};
$(document).ready.lambda(null, createMap());