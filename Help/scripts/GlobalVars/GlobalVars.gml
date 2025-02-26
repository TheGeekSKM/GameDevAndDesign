

enum ButtonState
{
    Idle,
    Hover,
    Click
}

enum ContainerType
{
    UpDown,
    LeftRight
}

enum ScreenType 
{
    Right,
    Left,
    Center
}

#macro camY 0
#macro camX 0


function Vars() constructor {
    pause = false;
    debug = false;
    single = false;
    playerList = [];
    cameras = [];
    
    function PauseGame(_id) {
        Raise("Pause", _id);
        pause = true;
    }
    
    function ResumeGame(_id) {
        Raise("Resume", _id);
        pause = false;
    }
    
    function AddPlayerToList(_id)
    {
        array_push(playerList, _id);
    }
}

function Button(_id) constructor 
{
    
    x = 0;
    y = 0;
    width = 0;
    height = 0;
    
    function SetDimensions(_x, _y, _w, _h) constructor 
    {
        x = _x;
        y = _y;
        width = _w;
        height = _h;
        
        return self;
    }
    
    owner = _id;
    
    currentState = ButtonState.Idle;
    
    function SetState(_state)
    {
        currentState = _state;
    }
    
    spriteIdle = noone;
    spriteHover = noone;
    spriteClick = noone;
    
    function SetSprite(sprI, sprH = noone, sprC = noone)
    {
        spriteIdle = sprI;
        spriteHover = sprH == noone ? spriteHover : sprH;
        spriteClick = sprC == noone ? spriteClick : sprC;
        
        return self;
    }
    
    text = "";
    textColor = c_black;
    textFontIdle = "CustomFont";
    textFontHover = "CustomFont_Effects";
    
    function SetText(_t, _tC = c_black, _tFI = "CustomFont", _tFH = "CustomFont_Effect")
    { 
        text = _t;
        textColor = _tC;
        textFontIdle = _tFI;
        textFontHover = _tFH;
        
        return self;   
    }
    
    textPos = new Vector2(0, 0);
    
    idleColor = c_white;
    hoverColor = make_color_hsv(158, 225, 100);
    clickColor = make_color_hsv(158, 225, 225);
    
    function SetColor(_iC, _hC = undefined, _cC = undefined)
    {
        idleColor = _iC;
        hoverColor = _hC == undefined ? make_color_hsv(158, 225, 100) : _hC;
        clickColor = _cC == undefined ? make_color_hsv(158, 225, 225) : _cC;
        
        return self;
    }
    
    function OnClick() {}
    
    function Draw()
    {
        var displayText = "";
        var textCol = textColor;
        var textYOffset = 0;
        var font = "";
        var currentSprite = spriteIdle;
        var currentColor = c_white;
        
        switch (currentState) 
        {
            case ButtonState.Idle:
                displayText = text;
                textCol = textColor;
                font = textFontIdle;
                currentSprite = spriteIdle;
                currentColor = idleColor;
                textYOffset = 0;            
                break;
                
            case ButtonState.Hover:
                displayText = string_concat("> ", text, " <");
                textCol = textColor;
                font = textFontHover;
                currentSprite = spriteHover;
                currentColor = hoverColor;
                textYOffset = 5;       
                break;    
                
            case ButtonState.Click:
                displayText = string_concat("> ", text, " <");
                textCol = textColor;
                font = textFontHover;
                currentSprite = spriteClick;
                currentColor = clickColor;
                textYOffset = 5;                                        
                break;            
        }
        
        draw_sprite_general(
            currentSprite, 0, x - (width / 2), y - (height / 2), 
            width, height, x, y, 1, 1, owner.image_angle, currentColor, 
            currentColor, currentColor, currentColor, 1
        );
        
        scribble(displayText)
            .align(fa_center, fa_middle)
            .starting_format(font, textCol)
            .transform(1, 1, owner.image_angle)
            .draw(x, y + textYOffset);
        
    }
}

