
function UIElement(_sprite, _x, _y, _width, _height) constructor {
    self.x = _x;
    self.y = _y;
    function SetPos(_x, _y) {
        self.x = _x;
        self.y = _y;
        return self;
    }
    
    self.width = _width;
    self.height = _height;
    function SetSize(_width, _height) {
        self.width = _width;
        self.height = _height;
        return self;
    }
    
    self.sprite = spr_box;
    function SetSprite(_sprite) {
        self.sprite = _sprite;
        return self;
    }

    function Step() {}
    function Draw() {}
}

