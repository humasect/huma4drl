var TILEWIDTH = 24;
var TILEHEIGHT = 30;
var MAPWIDTH = 32;
var MAPHEIGHT = 24;
function forEachTile(fun) {
    for (var i = 0; i <= MAPWIDTH; i += 1) {
        for (var j = 0; j <= MAPHEIGHT; j += 1) {
            fun(i, j);
        };
        null;
    };
    return null;
};
function clearMap() {
    return $('#view').html('');
};
function tileId(x, y) {
    return 'tile_' + x + '_' + y;
};
function setTile(x, y, type) {
    var c = $(tileId(x, y));
    var class = eq(type, '#') ? 'wall' : null;
    return c.html(type).addClass(class);
};
function createMap() {
    return forEachTile(function (x, y) {
        var c = $('<div/>');
        var left = x * TILEWIDTH + 64;
        var top = y * TILEHEIGHT + 64;
        c.attr('id', tileId(x, y)).addClass('tile').css({ 'left' : left, 'top' : top, 'background-color' : 'green' }).html('#');
        return $('#view').append(c);
    });
};
$(document).ready(createMap);