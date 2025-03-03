var vertical = keyboard_check_pressed(ord("S")) - keyboard_check_pressed(ord("W"));
var horizontal = keyboard_check_pressed(ord("D")) - keyboard_check_pressed(ord("A"));
var select = keyboard_check_pressed(ord("E"))

if (vertical != 0)
{
    selectIndex = ModWrap(selectIndex + vertical, 3);
}

if (horizontal != 0 and !ready)
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
    global.vars.attributesOne = new Attributes(strPoints, dexPoints, conPoints);    
}