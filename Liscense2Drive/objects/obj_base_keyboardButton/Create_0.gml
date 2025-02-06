hovering = false;
clicked = false;

AddToManager = function() {
    with (KeyboardButtonManager) {
        AddToKeyboardButtonManager(other.id);
        show_debug_message(string_concat("Added ", other.id, " to array!"));
        return;
    }
    show_debug_message("something went wrong");
    return;
}

OnHover = function() {
    hovering = true;    
}

OnIdle = function() {
    hovering = false;
}

OnClickStart = function() {
    clicked = true;
}

OnClickEnd = function()
{
    if (onClick != undefined) {
        onClick();
    }
    
    event_user(0);
}

AddToManager();


font_enable_effects(Born_DropShadow, true, { 
    dropShadowEnable: true,
    dropShadowSoftness: 5,
    dropShadowOffsetX: 1,
    dropShadowOffsetY: 1,
    dropShadowAlpha: 0.3
    
});
