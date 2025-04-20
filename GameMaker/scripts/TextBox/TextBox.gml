function TextBox(_owner, _sprite, _x, _y, _width, _height) : UIElement(_sprite, _x, _y, _width, _height) constructor {
    self.owner = _owner;

    self.padding = 5;
    function SetPadding(_padding) {
        self.padding = _padding;
        return self;
    }

    self.fontUsed = VCR_OSD_Mono; // Optional: assign a font here
    function SetFont(_font) {
        self.fontUsed = _font;
        return self;
    }

    self.textColor = c_white; // Optional: assign a color here
    function SetTextColor(_color) {
        self.textColor = _color;
        return self;
    }

    self.lineHeight = 20;
    self.messageList = []; // Array to hold messages
    self.scrollOffset = 0; // Current scroll offset
    self.targetScrollOffset = 0; // Target scroll offset for smooth scrolling
    self.scrollSpeed = 0.2; // Speed of scrolling

    function AddMessage(_msg) {
        array_push(self.messageList, _msg); // Add the new message to the list
        
        var scribbleStruct = scribble($"> {_msg}")
            .align(fa_left, fa_top)
            .starting_format("VCR_OSD_Mono")
            .transform(0.75, 0.75, 0)
            .wrap(self.width * 1.333); // Adjust wrap width as needed
        
        self.lineHeight = scribbleStruct.get_height(); // Get the height of the line
        
        var totalHeight = array_length(self.messageList) * (self.lineHeight + self.padding); // Calculate total height of messages
        if (totalHeight > self.height) {
            var overflow = totalHeight - self.height; // Calculate overflow
            self.targetScrollOffset = overflow; // Set target scroll offset
        }
    }

    function ClearBox() {
        self.messageList = []; // Clear the message list
        self.scrollOffset = 0; // Reset scroll offset
        self.targetScrollOffset = 0; // Reset target scroll offset
        self.scrollSpeed = 0.2; // Reset scroll speed
    }
    
    function Step() {
        var mouseX = device_mouse_x_to_gui(0);
        var mouseY = device_mouse_y_to_gui(0);

        if (!point_in_rectangle(mouseX, mouseY, self.x, self.y, self.x + self.width, self.y + self.height)) {
            return; // Exit if the mouse is outside the text box area
        }

        // Scroll with mouse wheel
        var scrollDir = mouse_wheel_up() - mouse_wheel_down();
        self.targetScrollOffset -= scrollDir * (self.lineHeight + self.padding); // Adjust target scroll offset based on scroll direction

        // Clamp to scrollable range
        var contentHeight = array_length(self.messageList) * (self.lineHeight + self.padding); // Calculate content height
        self.targetScrollOffset = clamp(self.targetScrollOffset, 0, max(0, contentHeight - self.height)); // Clamp target scroll offset

        // Smooth scroll
        self.scrollOffset = lerp(self.scrollOffset, self.targetScrollOffset, self.scrollSpeed); // Smoothly transition to target scroll offset
    }

    function Draw() {
        var yy = self.y - self.scrollOffset; // Calculate Y position for drawing messages
        var lineX = self.x + self.padding; // X position for drawing messages

        // Draw the background sprite or UI element
        draw_sprite_ext(self.sprite, 0, self.x, self.y, (self.width / sprite_get_width(self.sprite)), (self.height / sprite_get_height(self.sprite)), 0, c_white, 1);
        //draw_sprite_ext(self.sprite, 0, 150, 250, 1, 2, 0, c_white, 1);
        
        // Go through each line in the message list
        for (var i = 0; i < array_length(self.messageList); i++) {
            var line = self.messageList[i]; // Get the current line

            scribble($"> {line}")
                .align(fa_left, fa_top)
                .starting_format("VCR_OSD_Mono")
                .transform(0.75, 0.75, 0)
                .wrap(self.width * 1.333) // Adjust wrap width as needed
                .draw(lineX, yy); // Draw the line at the calculated position

            yy += self.lineHeight + self.padding; // Move down for the next line
        }
    }
}