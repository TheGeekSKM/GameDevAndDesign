// Inherit the parent event
event_inherited();
image_blend = IdleColor;
image_index = 1;

buttonClickCallbacks = [];
textColor = global.vars.Colors.c_lightParchment;



AddMouseEnterCallback(function() {
    image_index = 0;
    image_blend = HoverColor;
    textColor = global.vars.Colors.c_parchment;
    
});

AddMouseExitCallback(function() {
    image_index = 1;
    image_blend = IdleColor;
    textColor = global.vars.Colors.c_lightParchment;
})

function OnMouseLeftClick() 
{
    if (currentState == ButtonState.Hover)
    {
        currentState = ButtonState.Click;
        image_blend = ClickColor;
        textColor = global.vars.Colors.c_orangePalette;
    }
}

function OnMouseLeftClickRelease() 
{
    if (currentState == ButtonState.Click)
    {
        currentState = ButtonState.Hover;
        image_blend = HoverColor;
            textColor = global.vars.Colors.c_parchment;

        for (var i = 0; i < array_length(buttonClickCallbacks); i++) {
            var callback = buttonClickCallbacks[i];
            if (callback != undefined) {
                callback();
            }
        }
    }
}

function AddButtonClickCallback(callback) 
{
    array_push(buttonClickCallbacks, callback);
}
