var player1PosMult = new Vector2(100, 112);
var player2PosMult = new Vector2(300, 112);

var player1PosSingle = new Vector2(200, 112);

if (global.vars.single)
{
    instance_create_layer(player1PosSingle.x, player1PosSingle.y, "Players", obj_Player1);
}
else {
    instance_create_layer(player1PosMult.x, player1PosMult.y, "Players", obj_Player1);
    instance_create_layer(player2PosMult.x, player2PosMult.y, "Players", obj_Player2);        
}