// Inherit the parent event
event_inherited();
itemRequired = undefined;
function SetItemRequired(_item)
{
    itemRequired = _item;
}

function OnInteract()
{
    if (itemRequired != undefined)
    {
        var inventory = playerInRange.inventory;
        if (inventory.ContainsItem(itemRequired))
        {
            inventory.DeleteItem(itemRequired, 1);
            PermittedInteract();
        }
        else
        {
            var str = $"You need the {itemRequired.name} for this.";
            Raise("NotificationOpen", [str, playerInRange.PlayerIndex]);
        }
    }
    else
    {
        PermittedInteract();
    }
}

function PermittedInteract() {}
