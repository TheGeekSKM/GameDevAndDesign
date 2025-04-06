// Inherit the parent event
event_inherited();

SetItemRequired(global.vars.ItemLibrary.Pickaxe);

function PermittedInteract(_id)
{
    playerInRange = _id;
    image_xscale -= 0.25;
    image_yscale -= 0.25;

    image_xscale = max(0.1, image_xscale);
    image_yscale = max(0.1, image_yscale);

    if (image_xscale <= 0.1)
    {
        alarm[0] = irandom_range(5, 20) * 60;
    }
    else
    {
        var count = irandom_range(1, 3);
        playerInRange.inventory.AddItem(global.vars.ItemLibrary.CopperPiece, count);
    }
}

image_angle = irandom(360);
image_xscale = 1.5;
image_yscale = 1.5;
