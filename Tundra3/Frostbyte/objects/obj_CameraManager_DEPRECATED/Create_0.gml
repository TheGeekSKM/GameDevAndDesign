view_enabled = true;

view_visible[0] = false;
view_visible[1] = true;
view_visible[2] = true;

alwaysSplit = true;

var fullWidth = 400;
var fullHeight = 224;

var borderSize = 3;
var splitViewWidth = (fullWidth - borderSize) * 0.5;
var rightCameraX = (fullWidth + borderSize) * 0.5;

// Set the viewport for camera 0
view_set_xport(0, 0);
view_set_yport(0, 0);

view_set_wport(0, fullWidth);
view_set_hport(0, fullHeight);

// Set the viewport for camera 1
view_set_xport(1, 0);
view_set_yport(1, 0);

view_set_wport(1, splitViewWidth);
view_set_hport(1, fullHeight);

// Set the viewport for camera 2
view_set_xport(2, rightCameraX);
view_set_yport(2, 0);

view_set_wport(2, splitViewWidth);
view_set_hport(2, fullHeight);

// Create the cameras
CAMERA_COMBINED = camera_create_view(0, 0, fullWidth, fullHeight);
view_set_camera(0, CAMERA_COMBINED);

CAMERA_LEFT = camera_create_view(0, 0, splitViewWidth, fullHeight, 0, global.vars.Players[0], -1, -1, splitViewWidth, fullHeight);
view_set_camera(1, CAMERA_LEFT);

CAMERA_RIGHT = camera_create_view(rightCameraX, 0, splitViewWidth, fullHeight, 0, global.vars.Players[1], -1, -1, splitViewWidth, fullHeight);
view_set_camera(2, CAMERA_RIGHT);

array_push(global.vars.Cameras, CAMERA_COMBINED);
array_push(global.vars.Cameras, CAMERA_LEFT);
array_push(global.vars.Cameras, CAMERA_RIGHT);

global.playerBounds = [0, 0, 0, 0];

window_set_size(fullWidth * 2, fullHeight * 2);
surface_resize(application_surface, fullWidth * 2, fullHeight * 2);

function UpdateCameraCombined(minX, minY, maxX, maxY)
{
    // Set the camera to the center of the players
    var newX = (minX + maxX - camera_get_view_width(CAMERA_COMBINED)) * 0.5;
    var newY = (minY + maxY - camera_get_view_height(CAMERA_COMBINED)) * 0.5;
    camera_set_view_pos(CAMERA_COMBINED, newX, newY);
}