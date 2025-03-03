var vertical = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
var horizontal = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
var select = keyboard_check_pressed(vk_rcontrol);

if (vertical != 0)
{
    selectIndex = ModWrap(selectIndex + vertical, 3);
}

if (horizontal != 0 and totalPoints > 0 and !ready)
{
    if (totalPoints <= 0 and horizontal > 0) horizontal = 0;
    if (totalPoints >= 8 and horizontal < 0) horizontal = 0;
    switch (selectIndex)
    {
        case 0: conPoints += horizontal; totalPoints -= horizontal; break;
        case 1: strPoints += horizontal; totalPoints -= horizontal; break;
        case 2: dexPoints += horizontal; totalPoints -= horizontal; break;
    }
}

if (select) 
{
    ready = !ready;
    global.vars.attributesTwo = new Attributes(strPoints, dexPoints, conPoints);    
}