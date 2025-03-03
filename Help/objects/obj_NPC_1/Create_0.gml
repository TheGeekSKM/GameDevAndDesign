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
        Raise("DialogueOpen", new DialogueData(id, "Listen! We need your help! [c_yellow]Feed the Gaming PC by dropping parts that it requires.[c_white] Be careful though, the vicious viruses are deadly. [c_yellow]Stand still to shoot them.[c_white] Stay safe!!", playerInRange));
        timesInteracted++;
    }
    else {
        Raise("DialogueOpen", new DialogueData(id, "Brave Heroes, you must [wave]find the Broken Machine and drop parts near it[/wave] to feed it and fix the game! Please, the fate of this game relies on you!!!!", playerInRange.id));
    }    
}