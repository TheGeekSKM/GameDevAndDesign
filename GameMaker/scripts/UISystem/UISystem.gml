

function Button(_sprite, _text, _x, _y, _width, _height, _isGUI, _callbackFunction) constructor {
    self.sprite = _sprite;
    self.x = _x;
    self.y = _y;
    self.width = _width;
    self.height = _height;
    self.isGUI = _isGUI;
    self.text = _text;
    self.callbackFunction = _callbackFunction;
    self.currentState = ButtonState.Idle;

    function Step()
    {
        var mouseX = isGUI ? mouse_x : device_mouse_x_to_gui(0);
        var mouseY = isGUI ? mouse_y : device_mouse_y_to_gui(0);

        if (point_in_rectangle(mouseX, mouseY, self.x, self.y, self.x + self.width, self.y + self.height)) {

            currentState = ButtonState.Hover;

            var leftClick = mouse_check_button_pressed(0);
            var leftClickHeld = mouse_check_button(0);
            var leftClickReleased = mouse_check_button_released(0);

            if (leftClick || leftClickHeld) currentState = ButtonState.Click;
            else if (leftClickReleased) {
                currentState = ButtonState.Hover;
                if (self.callbackFunction != undefined) self.callbackFunction();
            }
        }
        else
        {
            currentState = ButtonState.Idle;
        }
        
       
    }


    function Draw() {
        var xScale = width / sprite_get_width(self.sprite);
        var yScale = height / sprite_get_height(self.sprite);
        var ind = 0;
        
        
        switch (self.currentState) {
            case ButtonState.Hover:
                ind = 1;
            break;
            case ButtonState.Click:
                ind = 2;
            break;
        }

        draw_sprite_ext(self.sprite, ind, self.x, self.y, xScale, yScale, 0, c_white, 1);
        scribble(self.text)
            .align(fa_center, fa_middle)
            .starting_format("VCR_OSD_Mono", c_white)
            .transform(1, 1, 0)
            .draw(x + (width / 2), y + (height / 2));
             
    }
}