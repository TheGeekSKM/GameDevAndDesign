var p1 = obj_Player1;
var minX = p1.x;
var maxX = p1.x;
var minY = p1.y;
var maxY = p1.y;

var p2 = obj_Player2
minX = min(minX, p2.x);
minY = min(minY, p2.y);
maxX = max(maxX, p2.x);
maxY = max(maxY, p2.y);

var borderSize = 50;

if ((maxX - minX) > (camera_get_view_width(CAMERA_COMBINED) - 3 * borderSize) || (maxY - minY) > (camera_get_view_height(CAMERA_COMBINED) - 2 * borderSize)) 
{
    if (view_visible[0])
    {
        view_visible[0] = false;
        view_visible[1] = true;
        view_visible[2] = true;
    }

}
else
{
    if (!view_visible[0])
    {
        view_visible[0] = true;
        view_visible[1] = false;
        view_visible[2] = false;
    }
    UpdateCameraCombined(minX, minY, maxX, maxY);
}

