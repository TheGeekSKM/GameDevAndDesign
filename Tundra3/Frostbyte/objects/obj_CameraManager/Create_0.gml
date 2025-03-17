view_enabled = true;

view_visible[0] = true;
view_visible[1] = false;
view_visible[2] = false;

var fullWidth = 400;
var fullHeight = 224;

var borderSize = 3;
var splitViewHeight = (fullHeight - borderSize) * 0.5;
var bottomCameraY = (fullHeight + borderSize) * 0.5;

// Set the viewport for camera 0
view_set_xport(0, 0);
view_set_yport(0, 0);

view_set_wport(0, fullWidth);
view_set_hport(0, fullHeight);

// Set the viewport for camera 1
view_set_xport(1, 0);
view_set_yport(1, 0);

view_set_wport(1, fullWidth);
view_set_hport(1, splitViewHeight);

// Set the viewport for camera 2
view_set_xport(2, 0);
view_set_yport(2, bottomCameraY);

view_set_wport(2, fullWidth);
view_set_hport(2, splitViewHeight);

// Create the cameras
CAMERA_COMBINED = camera_create_view(0, 0, fullWidth, fullHeight);
view_set_camera(0, CAMERA_COMBINED);
camera_set_update_script(CAMERA_COMBINED, CamScriptBothPlayers);

CAMERA_TOP = camera_create_view(0, 0, fullWidth, splitViewHeight, 0, obj_Player1);
view_set_camera(1, CAMERA_TOP);

CAMERA_BOTTOM = camera_create_view(0, bottomCameraY, fullWidth, splitViewHeight, 0, obj_Player2);
view_set_camera(2, CAMERA_BOTTOM);

array_push(global.vars.Cameras, CAMERA_COMBINED);
array_push(global.vars.Cameras, CAMERA_TOP);
array_push(global.vars.Cameras, CAMERA_BOTTOM);

global.playerBounds = [0, 0, 0, 0];