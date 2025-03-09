depth = -9999
currentState = MouseState.Normal;
IsOverUI = false;

Subscribe("MouseOver", function(_type) {
    currentState = _type;
});

Subscribe("MouseLeave", function(_type) {
    currentState = MouseState.Normal;
});

Subscribe("MouseOverUI", function(_type) {
    IsOverUI = true;
});

Subscribe("MouseNotOverUI", function(_type) {
    IsOverUI = false;
});

function FindLowestDepthElement()
{
    
}

