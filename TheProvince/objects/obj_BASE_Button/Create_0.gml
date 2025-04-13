// Inherit the parent event
event_inherited();
image_blend = IdleColor;
image_index = 1;

buttonClickCallbacks = [];


AddMouseEnterCallback(function() {
    image_index = 0;
    image_blend = HoverColor;
});

AddMouseExitCallback(function() {
    image_index = 1;
    image_blend = IdleColor;
})

function OnMouseLeftClick() 
{
    if (currentState == ButtonState.Hover)
    {
        currentState = ButtonState.Click;
        image_blend = ClickColor;
    }
}

function OnMouseLeftClickRelease() 
{
    if (currentState == ButtonState.Click)
    {
        currentState = ButtonState.Hover;
        image_blend = HoverColor;

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
