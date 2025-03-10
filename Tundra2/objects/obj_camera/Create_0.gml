enum CameraMode {
    FollowObject,
    FollowMouseDrag,
    FollowMouseBorder,
    FollowMousePeek,
    MoveToTarget,
    MoveToFollowTarget
}

currentState = StartingState;

target = new Vector2(200, 200);
mousePrevious = new Vector2(-1, -1);


view_enabled = true;
view_visible[CameraIndex] = true;

function SetCameraMode(_state, _following = noone, _targetPos = new Vector2(-1, -1))
{
    currentState = _state;
    FollowingObject = _following;
    if (_targetPos.x != -1 || _targetPos.y != -1) target.Set(x, y);
    else target = new Vector2(_targetPos.x, _targetPos.y); 
}

view_camera[CameraIndex] = camera_create_view(0, 0, CamWidth, CamHeight);