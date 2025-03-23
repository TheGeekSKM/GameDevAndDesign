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
            var str = $"You need a {itemRequired.name} to interact with this object.";
            Raise("NotificationOpen", [str, playerInRange.PlayerIndex]);
        }
    }
    else
    {
        PermittedInteract();
    }
}

function PermittedInteract() {}
