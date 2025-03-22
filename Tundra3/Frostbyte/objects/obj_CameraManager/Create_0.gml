view_enabled = true;
    
var width = 400;
var height = 224;
var scale = 1.5;

    
for (var i = 0; i < array_length(global.vars.Players); i++)
{
    view_visible[i] = true;
        
    // Create Camera
    var camWidth = width / array_length(global.vars.Players);
    global.vars.Cameras[i] = camera_create_view(0, 0, camWidth, height, 0, global.vars.Players[i], -1, -1, camWidth, height);
        
    view_set_camera(i, global.vars.Cameras[i]);
        
    // Viewport
    view_xport[i] = camWidth * i;
    view_yport[i] = 0;
    view_wport[i] = camWidth;
    view_hport[i] = height;
}
surface_resize(application_surface, width * 2, height * 2);