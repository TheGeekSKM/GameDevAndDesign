// Inherit the parent event
event_inherited();

dragRect = new Rectangle(x - (sprite_width / 2), y - (sprite_height / 2), x + (sprite_width / 2), y + (sprite_height / 2));
topLeft = new Vector2(x - (sprite_width / 2), y - (sprite_height / 2));

closeButton.x = topLeft.x + sprite_width;
closeButton.y = topLeft.y;
stateMachine.step();
