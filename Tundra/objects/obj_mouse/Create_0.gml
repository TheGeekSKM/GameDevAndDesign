depth = -9999
currentState = MouseState.Normal;

Subscribe("MouseOver", function(_type) {
    currentState = _type;
});


Subscribe("MouseLeave", function(_type) {
    currentState = MouseState.Normal;
});

