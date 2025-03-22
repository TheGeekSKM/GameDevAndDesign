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
    instance_destroy()
}
function WhilePlayerInRange() {}