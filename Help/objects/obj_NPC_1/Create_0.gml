// Inherit the parent event
event_inherited();

interactableName = ChooseFromArray(global.vars.npcNames);
npcColor = make_color_hsv(irandom(255), 55, 150);
sprite_index = spr_human;
image_blend = npcColor
image_speed = 0;
image_index = 1;
timesInteracted = 0;

quest = new Quest("Find The Broken Machine", 
    string_concat(interactableName, " wants to find the Broken Machine and [wave]drop parts near it[/wave] to feed it and fix the game! Find it before it's too late!"));
function OnInteract()
{
    if (playerInRange == noone) return;
    
    if (timesInteracted == 0) {
        global.vars.AddQuest(quest);
        Raise("DialogueOpen", new DialogueData(id, "Greetings, brave heroes. It seems that the Ultimate Gaming PC is missing some parts and needs your help. First, [wave]find the Ultimate Gaming PC[/wave], and then [wave]drop the parts it needs[/wave] to save the world!!", playerInRange));
        timesInteracted++;
    }
    else {
        Raise("DialogueOpen", new DialogueData(id, "Brave Heroes, you must [wave]find the Broken Machine and drop parts near it[/wave] to feed it and fix the game! Please, the fate of this game relies on you!!!!", playerInRange.id));
    }    
}