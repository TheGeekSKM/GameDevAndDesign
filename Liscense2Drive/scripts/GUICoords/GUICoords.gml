function RoomToGUICoords(_x, _y)
{
    var cx = camera_get_view_x(view_camera[0]);
    var cy = camera_get_view_y(view_camera[0]);
    
    var off_x = _x - cx;
    var off_y = _y - cy;
    
    var offXPercent = off_x / camera_get_view_width(view_camera[0]);
    var offYPercent = off_y / camera_get_view_height(view_camera[0]);
    
    var guiX = offXPercent * display_get_gui_width();
    var guiY = offYPercent * display_get_gui_height();
    
    return new Vector2(guiX, guiY);
}