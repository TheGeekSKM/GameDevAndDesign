// Inherit the parent event
event_inherited();

playerInRange = noone;

recipe = undefined;

function SetRecipe(_recipe)
{
    recipe = _recipe
    interactableName = recipe.name;
    Name = interactableName;
}

function OnMouseLeftClick() {
    Raise("PickUp", id);   
    //if (instance_exists(global.vars.Player) and PlayerIsWithinRange())
    //{
        
    //}
}

function Collect(_id) {
    if (recipe == undefined) return;
    DiscoverRecipe(recipe);
    var txt = instance_create_layer(x, y, "GUI", obj_PopUpText)
    txt.Init($"Picked Up {recipe.name} Recipe", c_aqua);
    instance_destroy()
}