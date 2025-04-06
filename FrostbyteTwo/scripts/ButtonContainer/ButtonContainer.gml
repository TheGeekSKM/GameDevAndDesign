function ButtonContainer(_owner, _isVertical = true) constructor {
    owner = _owner;
    isVertical = _isVertical;
    padding = 0;
    spacing = 0;
    PossibleHeight = 0;
    PossibleWidth = 0;

    buttonObjectToSpawn = obj_BASE_Button; // default button object to spawn
    function SetPadding(p) { padding = p; return self; }
    function SetSpacing(s) { spacing = s; return self; }
    function SetVertical(v) { isVertical = v; return self; }
    function SetButtonObjectToSpawn(obj) { buttonObjectToSpawn = obj; return self; }

    buttonDatas = [];
    function AddButton(_buttonText, _buttonHoverColor, _buttonClickColor, _buttonClickFunction, _buttonVariablesStruct = {})
    {
        var buttonData = new ButtonData(_buttonText, _buttonHoverColor, _buttonClickColor, _buttonClickFunction, _buttonVariablesStruct);
        array_push(buttonDatas, buttonData);
        return self;
    }

    buttonPositions = [];
    buttonObjects = [];
    function Create()
    {
        var buttonCount = array_length(buttonDatas);
        PossibleWidth = owner.sprite_width - (padding * 2);
        PossibleHeight = owner.sprite_height - (padding * 2) - 18;
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
                buttonSpacing = PossibleHeight / buttonCount;
                buttonWidth = PossibleWidth;
                buttonHeight = round(buttonSpacing - spacing);
            }
            else
            {
                buttonSpacing = PossibleWidth / buttonCount;
                buttonHeight = PossibleHeight;
                buttonWidth = round(buttonSpacing - spacing);
            }

            var xPos = 0;
            var yPos = 0;

            if (isVertical)
            {
                xPos = 0; // assuming the owner's origin is in the middle
                yPos = topLeft.y + (buttonSpacing * i) + padding;
            }
            else
            {
                xPos = topLeft.x + (buttonSpacing * i) + padding;
                yPos = 0; // assuming the owner's origin is in the middle
            }

            var buttonData = buttonDatas[i];
            array_push(buttonPositions, new Vector2(xPos, yPos));
            var button = instance_create_depth(owner.x + xPos, owner.y + yPos, owner.depth - 1, buttonObjectToSpawn, buttonData.variableStruct);
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

    function RemoveButton(_index)
    {
        if (_index < 0 || _index >= array_length(buttonObjects)) return self; // out of bounds
        var button = buttonObjects[_index];
        button.Destroy();
        array_delete(buttonObjects, _index, 1);
        array_delete(buttonPositions, _index, 1);
        array_delete(buttonDatas, _index, 1);
        return self;
    }

    function ClearButtons()
    {
        var buttonCount = array_length(buttonObjects);
        for (var i = 0; i < buttonCount; i += 1)
        {
            var button = buttonObjects[i];
            instance_destroy(button);
        }

        buttonObjects = [];
        buttonPositions = [];
        buttonDatas = [];
        return self;
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

function ButtonData(_text, _hoverColor, _clickColor, _callback, _variableStruct) constructor {
    text = _text;
    hoverColor = _hoverColor;
    clickColor = _clickColor;
    callback = _callback;
    variableStruct = _variableStruct;
}