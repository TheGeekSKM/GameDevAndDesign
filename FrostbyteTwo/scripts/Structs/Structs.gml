function Rectangle(_x, _y, _width, _height) constructor {
    self.x = _x;
    self.y = _y;
    self.width = _width;
    self.height = _height;

    ///@pure
    ///@function Area()
    ///@description Returns the area of the rectangle.
    ///@returns {real} The area of the rectangle.
    self.Area = function() {
        return self.width * self.height;
    };

    ///@pure
    ///@function Perimeter()
    ///@description Returns the perimeter of the rectangle.
    ///@returns {real} The perimeter of the rectangle.

    self.Perimeter = function() {
        return 2 * (self.width + self.height);
    };

    ///@pure
    ///@function Contains(point_x, point_y)
    ///@description Checks if a point is inside the rectangle.
    ///@param {real} point_x The x-coordinate of the point.
    ///@param {real} point_y The y-coordinate of the point.
    ///@returns {bool} True if the point is inside the rectangle, false otherwise.
    self.Contains = function(point_x, point_y) {
        return (point_x >= self.x && point_x <= self.x + self.width &&
                point_y >= self.y && point_y <= self.y + self.height);
    };

    ///@function Move(delta_x, delta_y)
    ///@description Moves the rectangle by a specified delta.
    ///@param {real} delta_x The change in the x-coordinate.
    ///@param {real} delta_y The change in the y-coordinate.
    self.Move = function(delta_x, delta_y) {
        self.x += delta_x;
        self.y += delta_y;
    };

    ///@function Resize(new_width, new_height)
    ///@description Resizes the rectangle to new dimensions.
    ///@param {real} new_width The new width of the rectangle.
    ///@param {real} new_height The new height of the rectangle.
    self.Resize = function(new_width, new_height) {
        self.width = new_width;
        self.height = new_height;
    };

    ///@function UpdateAllDimensions(new_x, new_y, new_width, new_height)
    ///@description Updates all dimensions of the rectangle.
    ///@param {real} new_x The new x-coordinate of the rectangle.
    ///@param {real} new_y The new y-coordinate of the rectangle.
    ///@param {real} new_width The new width of the rectangle.
    ///@param {real} new_height The new height of the rectangle.
    ///@returns {undefined}
    self.UpdateAllDimensions = function(new_x, new_y, new_width, new_height) {
        self.x = new_x;
        self.y = new_y;
        self.width = new_width;
        self.height = new_height;
    };

    ///@pure
    ///@function ToString()
    ///@description Returns a string representation of the rectangle.
    ///@returns {string} A string representation of the rectangle.
    self.ToString = function() {
        return "Rectangle(" + self.x + ", " + self.y + ", " + self.width + ", " + self.height + ")";
    };
}