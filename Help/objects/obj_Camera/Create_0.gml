view_enabled = true;
    
var width = 400;
var height = 224;
var scale = 1.5;
    
for (var i = 0; i < array_length(global.vars.playerList); i++)
{
    view_visible[i] = true;
        
    // Create Camera
    var camWidth = width / array_length(global.vars.playerList);
    global.vars.cameras[i] = camera_create_view(0, 0, camWidth, height, 0, global.vars.playerList[i], -1, -1, camWidth, height);
        
    view_set_camera(i, global.vars.cameras[i]);
        
    // Viewport
    view_xport[i] = camWidth * i;
    view_wport[i] = camWidth;
}
    
surface_resize(application_surface, width, height);