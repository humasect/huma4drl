function Actor(name, char, x, y) {
    return { name : name, pos : pointMake(x, y), 'char' : char };
};
function actorRender(a) {
    console.log(a);
    CTX.fillStyle = 'yellow';
    return CTX.fillText(a['char'], a.pos.x, a.pos.y);
};