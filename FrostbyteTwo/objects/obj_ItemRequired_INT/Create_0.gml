// Inherit the parent event
event_inherited();

itemRequired = undefined;
function SetItemRequired(_item)
{
    itemRequired = _item;
}

function OnMouseLeftClick() {
    Raise("PickUp", id);   
    //if (instance_exists(global.vars.Player) and PlayerIsWithinRange())
    //{
        
    //}
}

function Collect(_id)
{
    if (itemRequired != undefined)
    {
        if (!instance_exists(global.vars.Player)) return;
        var player = global.vars.Player;    
        
        var inventory = player.inventory;
        var slotIndex = inventory.ContainsItem(itemRequired);
        if (slotIndex != -1)
        {
            inventory.UseItemByIndex(slotIndex, 1);
            PermittedInteract(_id);
        }
        else
        {
            var str = $"You need the {itemRequired.name} for this.";
            var popUp = instance_create_layer(x, y, "GUI", obj_PopUpText)
            popUp.Init(str);
        }
    }
    else
    {
        PermittedInteract(_id);
    }
}

function PermittedInteract(_id) {}