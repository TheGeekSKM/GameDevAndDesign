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
        var slotIndex = inventory.ContainsItem(itemRequired);
        if (slotIndex != -1)
        {
            inventory.UseItemByIndex(slotIndex, 1);
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
