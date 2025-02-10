randomize();
playerInRange = false;

//Not Interactable Variables
turnCounter = 0;
timeTillTurn = irandom_range(2, 15);
turnSpeed = 0.1;
angleToLookAt = random(360);

//Interactable Variables
spriteExclamation = spr_exclamationPoint;
textToDisplay = string_concat(interactableName, "\n", interactableDescription);

Subscribe("J Pressed", function() {
    if (!playerInRange) return;
    
    OnInteract();    
});

OnInteract = function()
{
    
}

TurnToLook = function()
{
    turnCounter++;
    if (turnCounter >= (timeTillTurn * 60))
    {
        image_angle = lerp(image_angle, angleToLookAt, turnSpeed);
        if (abs(image_angle - angleToLookAt) <= 10)
        {
            timeTillTurn = irandom_range(2, 15);
            angleToLookAt = random(360);
            turnCounter = 0;
        }       
    }
}

RemoveExclamation = function()
{
    spriteExclamation = noone;
}


enum InteractableState
{
    NotInteractable,
    Interactable
}

currentInteractableState = InteractableState.NotInteractable;

function OnInteractableEnter()
{
    switch (currentInteractableState)
    {
        case InteractableState.NotInteractable:
            break;
        case InteractableState.Interactable:
            break;
    }    
}

function OnInteractableExit()
{
    switch (currentInteractableState)
    {
        case InteractableState.NotInteractable:
            break;
        case InteractableState.Interactable:
            break;
    }
}

function OnInteractableDraw()
{
    switch (currentInteractableState)
    {
        case InteractableState.NotInteractable:
            draw_self();
            break;
        case InteractableState.Interactable:
            draw_self();
            break;
    }
    
    if (playerInRange and spriteExclamation != noone) draw_sprite_ext(spriteExclamation, 0, x, y - ((sprite_height / 2) + 5), 1, 1, 0, c_white, 1);
}

function OnInteractableDrawGUI()
{
    if (!playerInRange) return;
    var guiPos = RoomToGUICoords(x, y + ((sprite_height / 2) + 5));
                
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_font(Born);
    draw_set_color(c_black);
            
    draw_text(guiPos.x, guiPos.y, textToDisplay);
            
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}



LookAtPlayer = function()
{
    var dir = point_direction(x, y, obj_player.x, obj_player.y);
    image_angle = dir;
}

function SwitchState(_state)
{
    OnInteractableExit();
    currentInteractableState = _state;
    OnInteractableEnter();
}