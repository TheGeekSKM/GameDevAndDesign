function Recipe(_name, _requiredItems, _outputItems) constructor {
    name = _name;
    requiredItems = _requiredItems;
    outputItems = _outputItems;

    function AddRequiredItem(_item, _amount) {
        if (_amount <= 0) {
            show_message("Amount must be greater than 0");
            return;
        }

        var item = new RecipeItem(_item, _amount);

        if (requiredItems == undefined) {
            requiredItems = [];
            array_push(requiredItems, item);
        }
        else {
            var found = false;
            for (var i = 0; i < array_length(requiredItems); i++) {
                if (requiredItems[i].item == item.item) {
                    requiredItems[i].count += item.count;
                    found = true;
                    break;
                }
            }

            if (!found) {
                array_push(requiredItems, item);
            }
        }

        return self;
    }

    function AddOutPutItem(_item, _amount) {
        if (_amount <= 0) {
            show_message("Amount must be greater than 0");
            return;
        }

        var item = new RecipeItem(_item, _amount);
        if (outputItems == undefined) {
            outputItems = [];
            array_push(outputItems, item);
        }
        else {
            var found = false;
            for (var i = 0; i < array_length(outputItems); i++) {
                if (outputItems[i].item == item.item) {
                    outputItems[i].count += item.count;
                    found = true;
                    break;
                }
            }

            if (!found) {
                array_push(outputItems, item);
            }
        }
    }

    function Craft(_owner)
    {
        for (var i = 0; i < array_length(requiredItems); i++) {
            var index = _owner.inventory.ContainsItem(requiredItems[i].item);
            if (index == -1) {
                show_message($"You don't have {requiredItems[i].item.name} in your inventory");
                return;
            }

            if (_owner.inventory.allItems[index].quantity < requiredItems[i].count) {
                show_message($"You don't have enough {requiredItems[i].item.name}");
                return;
            }
        }

        for (var i = 0; i < array_length(requiredItems); i++) {
            var index = _owner.inventory.ContainsItem(requiredItems[i].item);
            _owner.inventory.RemoveItem(index, requiredItems[i].count);
        }

        for (var i = 0; i < array_length(outputItems); i++) {
            var index = _owner.inventory.ContainsItem(outputItems[i].item);
            _owner.inventory.AddItem(outputItems[i].item, outputItems[i].count);
        }

        show_message($"Crafting Successful!\nYou recieved {outputItems[0].count}x {outputItems[0].item.name}");
    }

    function ToString()
    {
        // Recipe: name
        // Required Items: 
        // - item1 xcount 
        // - item2 xcount 
        // - item3 xcount
        //
        // Output Items:
        // - item1 xcount
        // - item2 xcount
        // - item3 xcount

        var str = "";
        
        str = string_concat(str, "Recipe: ", name, "\n");
        str = string_concat(str, "Required Items:\n");
        for (var i = 0; i < array_length(requiredItems); i++) {
            str = string_concat(str, "- ", requiredItems[i].item.name, " x", string(requiredItems[i].count), "\n");
        }
        
        str = string_concat(str, "\nOutput Items:\n");
        for (var i = 0; i < array_length(outputItems); i++) {
            str = string_concat(str, "- ", outputItems[i].item.name, " x", string(outputItems[i].count), "\n");
        }
        
        return str;
    }
}

function RecipeItem(_item, _count) constructor {
    item = _item;
    count = _count;
}

function DiscoverRecipe(_recipe) {
    var found = false;
    for (var i = 0; i < array_length(global.vars.DiscoveredRecipes); i++) {
        if (global.vars.DiscoveredRecipes[i].name == _recipe.name) {
            found = true;
            break;
        }
    }

    if (!found) {
        array_push(global.vars.DiscoveredRecipes, _recipe);
    }
}

function GetNumberOfCrafting()
{
    return array_length(global.vars.DiscoveredRecipes);
}

function GetCraftingByIndex(_index)
{
    return global.vars.DiscoveredRecipes[_index];
}