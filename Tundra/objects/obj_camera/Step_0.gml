var cX = camera_get_view_x(view_camera[CameraIndex]);
var cY = camera_get_view_y(view_camera[CameraIndex]);

switch (currentState)
{
    case CameraMode.FollowObject:
        if (!instance_exists(FollowingObject)) break; 
        cX = FollowingObject.x - (viewWidth / 2);
        cY = FollowingObject.y - (viewHeight / 2);
    break;
    
    case CameraMode.FollowMouseDrag: 
        var currentMousePos = new Vector2(display_mouse_get_x(), display_mouse_get_y());
        
        if (mouse_check_button(mb_left))
        {
            cX += (mousePrevious.x - currentMousePos.x) * 0.5;
            cY += (mousePrevious.y - currentMousePos.y) * 0.5;
        }
        
        mousePrevious.Set(currentMousePos.x, currentMousePos.y);
    break;
    
    case CameraMode.FollowMouseBorder: 
        if (!point_in_rectangle(mouse_x, mouse_y, 
            cX + (viewWidth * 0.1), cY + (viewHeight * 0.1), 
            cX + (viewWidth * 0.9), cY + (viewHeight * 0.9)))
        {
            cX = lerp(cX, mouse_x - (viewWidth / 2), 0.05);
            cY = lerp(cY, mouse_y - (viewHeight / 2), 0.05);
        }
    break;
    
    case CameraMode.FollowMousePeek: 
        cX = lerp(FollowingObject.x, mouse_x, 0.2) - (viewWidth / 2);
        cY = lerp(FollowingObject.y, mouse_y, 0.2) - (viewHeight / 2);
    break;
    
    case CameraMode.MoveToTarget: 
        cX = lerp(cX, target.x - (viewWidth / 2), 0.1);
        cY = lerp(cY, target.y - (viewHeight / 2), 0.1);
    break;
    
    case CameraMode.MoveToFollowTarget: 
        if (!instance_exists(FollowingObject)) break; 
        cX = lerp(cX, FollowingObject.x - (viewWidth / 2), 0.1);
        cY = lerp(cY, FollowingObject.y - (viewHeight / 2), 0.1);
        
        if (point_distance(cX, cY, FollowingObjext.x - (viewWidth / 2), FollowingObject.y - (viewHeight / 2)) < 1)
        {
            currentState = CameraMode.FollowMousePeek;
        }
    break;
}

cX = clamp(cX, 0, room_width - viewWidth);
cY = clamp(cY, 0, room_height - viewHeight);

camera_set_view_pos(view_camera[CameraIndex], cX, cY);