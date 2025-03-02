// Inherit the parent event
event_inherited();

interactableName = ChooseFromArray(global.vars.npcNames);
sprite_index = spr_human;
image_blend = make_color_hsv(irandom(255), 55, 150);
image_speed = 0;
image_index = 1;
timesInteracted = 0;

quest = new Quest("Find The Broken Machine", 
    string_concat(interactableName, " wants to find the Broken Machine to fix the world! Find it before it's too late!"));

function OnInteract()
{
    if (playerInRange == noone) return;
    
    if (timesInteracted == 0) {
        global.vars.AddQuest(quest);
        timesInteracted++;
    }    
}