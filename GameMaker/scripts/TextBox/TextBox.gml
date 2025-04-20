function TextBox(_owner, _sprite, _x, _y, _width, _height) : UIElement(_sprite, _x, _y, _width, _height) constructor {
    self.owner = _owner;

    self.padding = 5;
    function SetPadding(_padding) {
        self.padding = _padding;
        return self;
    }

    self.fontUsed = VCR_OSD_Mono;
    function SetFont(_font) {
        self.fontUsed = _font;
        return self;
    }

    self.textColor = c_white;
    function SetTextColor(_color) {
        self.textColor = _color;
        return self;
    }

    self.mouseInRect = false;
    self.mouseX = 0;
    self.mouseY = 0;

    self.lineHeight = 20;
    self.messageList = [];
    self.scrollOffset = 0;
    self.targetScrollOffset = 0;
    self.scrollSpeed = 0.2;

    function AddMessage(_msg) {
        array_push(self.messageList, _msg);
        
        var scribbleStruct = scribble($"> {_msg}")
            .align(fa_left, fa_top)
            .starting_format("VCR_OSD_Mono")
            .transform(0.75, 0.75, 0)
            .wrap(self.width * 1.333);
        
        self.lineHeight = scribbleStruct.get_height();
        
        var totalHeight = array_length(self.messageList) * (self.lineHeight + self.padding);
        if (totalHeight > self.height) {
            var overflow = totalHeight - self.height;
            self.targetScrollOffset = overflow;
        }
    }

    function ClearBox() {
        self.messageList = [];
        self.scrollOffset = 0;
        self.targetScrollOffset = 0;
        self.scrollSpeed = 0.2;
    }
    
    function Step() {
        self.mouseX = device_mouse_x_to_gui(0);
        self.mouseY = device_mouse_y_to_gui(0);
        
        self.topLeft = new Vector2(self.x - (self.width / 2), self.y - (self.height / 2));
        
        var scrollDir = 0;
        
        if (point_in_rectangle(mouseX, mouseY, self.topLeft.x, self.topLeft.y, self.x + (self.width / 2), self.y + (self.height / 2))) {
            self.mouseInRect = true;
        }
        else {
            self.mouseInRect = false;
        }
        
        scrollDir = mouse_wheel_up() - mouse_wheel_down();
        //echo($"\n\n\nScroll Direction: {scrollDir}");
        self.targetScrollOffset -= scrollDir * (self.lineHeight + self.padding);
        //echo ($"Target Scroll Offset: {self.targetScrollOffset}");

        var contentHeight = array_length(self.messageList) * (self.lineHeight + self.padding);
        //echo ($"Content Height: {contentHeight}");
        
        self.targetScrollOffset = clamp(self.targetScrollOffset, 0, max(0, contentHeight - self.height));
        //echo ($"Clamped Target Scroll Offset: {self.targetScrollOffset}");
        self.scrollOffset = lerp(self.scrollOffset, self.targetScrollOffset, self.scrollSpeed);
        //self.scrollOffset = self.targetScrollOffset;
        echo ($"Scroll Offset: {self.scrollOffset} and Target Scroll Offset: {self.targetScrollOffset}");
    }

    function Draw() {
        var yy = self.topLeft.y - self.scrollOffset;
        var lineX = self.topLeft.x + self.padding;

        draw_sprite_ext(self.sprite, 0, self.x, self.y, (self.width / sprite_get_width(self.sprite)), (self.height / sprite_get_height(self.sprite)), 0, c_white, 1);
        if (self.mouseInRect) draw_text(150, 250, $"Bungus");
        draw_text(150, 250, $"{self.mouseX}, {self.mouseY}"); 

        for (var i = 0; i < array_length(self.messageList); i++) {
            var line = self.messageList[i];

            scribble($"{line}")
                .align(fa_left, fa_top)
                .starting_format("VCR_OSD_Mono")
                .transform(0.75, 0.75, 0)
                .wrap(self.width * 1.333)
                .draw(lineX, yy);

            yy += self.lineHeight + self.padding;
        }
    }
}
