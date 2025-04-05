function ButtonContainer(_owner, _isVertical = true) constructor {
    owner = _owner;
    isVertical = _isVertical;
    padding = 0;
    spacing = 0;
    function SetPadding(p) { padding = p; return self; }
    function SetSpacing(s) { spacing = s; return self; }
    function SetVertical(v) { isVertical = v; return self; }

    buttonDatas = [];
    function AddButton(_buttonText, _buttonHoverColor, _buttonClickColor, _buttonClickFunction)
    {
        var buttonData = new ButtonData(_buttonText, _buttonHoverColor, _buttonClickColor, _buttonClickFunction);
        array_push(buttonDatas, buttonData);
        return self;
    }

    buttonPositions = [];
    buttonObjects = [];
    function Create()
    {
        var buttonCount = array_length(buttonDatas);
        var possibleWidth = owner.sprite_width - (padding * 2);
        var possibleHeight = owner.sprite_height - (padding * 2) - 18;
        var topLeft = new Vector2(-1 * (owner.sprite_width / 2) + padding, -1 * (owner.sprite_height / 2) + padding + 18);

        for (var i = 0; i < buttonCount; i += 1)
        {
            
            var buttonHeight = 0;
            var buttonWidth = 0;

            // if we are vertical, we'll need to split the height of the possible height by the number of buttons
            // we can ignore padding because padding is only around the possible height/width and not in between the buttons
            var buttonSpacing = 0;
            if (isVertical)
            {
                buttonSpacing = possibleHeight / buttonCount;
                buttonWidth = possibleWidth;
                buttonHeight = round(buttonSpacing - spacing);
            }
            else
            {
                buttonSpacing = possibleWidth / buttonCount;
                buttonHeight = possibleHeight;
                buttonWidth = round(buttonSpacing - spacing);
            }

            var xPos = 0;
            var yPos = 0;

            if (isVertical)
            {
                xPos = 0; // assuming the owner's origin is in the middle
                yPos = topLeft.y + (buttonSpacing * i) + padding;
                echo($"Button {i} topLeft.y: {topLeft.y}, buttonSpacing: {buttonSpacing}, padding: {padding}, yPos: {yPos}", true);
            }
            else
            {
                xPos = topLeft.x + (buttonSpacing * i) + padding;
                yPos = 0; // assuming the owner's origin is in the middle
            }

            var buttonData = buttonDatas[i];
            array_push(buttonPositions, new Vector2(xPos, yPos));
            var button = instance_create_depth(owner.x + xPos, owner.y + yPos, owner.depth - 1, obj_BASE_Button);
            button
                .SetText(buttonData.text)
                .SetColors(buttonData.hoverColor, buttonData.clickColor)
                .AddCallback(buttonData.callback)
                .SetSize(buttonWidth, buttonHeight)
                .SetPosition(xPos, yPos)
                .SetDepth(owner.depth - 1);
            array_push(buttonObjects, button);
        }
    }

    function Step()
    {
        var buttonCount = array_length(buttonObjects);
        for (var i = 0; i < buttonCount; i += 1)
        {
            buttonObjects[i].SetPosition(owner.x + buttonPositions[i].x, owner.y + buttonPositions[i].y);
        }
    }
}

function ButtonData(_text, _hoverColor, _clickColor, _callback) constructor {
    text = _text;
    hoverColor = _hoverColor;
    clickColor = _clickColor;
    callback = _callback;
}