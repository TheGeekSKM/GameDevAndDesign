playerInRange = noone;
textToDisplay = $"{interactableName}\n{interactText}";

recipe = undefined;

function SetRecipe(_recipe)
{
    recipe = _recipe
    interactableName = recipe.name;
}

function OnInteract() {
    if (recipe == undefined) return;
    DiscoverRecipe(recipe);
    var txt = instance_create_layer(x, y, "GUI", obj_PopUpText)
    txt.Init($"Picked Up {recipe.name} Recipe", c_blue);
    instance_destroy()
}
function WhilePlayerInRange() {}