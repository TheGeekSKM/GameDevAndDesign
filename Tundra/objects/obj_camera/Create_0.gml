enum CameraMode {
    FollowObject,
    FollowMouseDrag,
    FollowMouseBorder,
    FollowMousePeek,
    MoveToTarget,
    MoveToFollowTarget
}

currentState = CameraMode.FollowMousePeek;

viewWidth = camera_get_view_width(view_camera[CameraIndex]);
viewHeight = camera_get_view_height(view_camera[CameraIndex]);

target = new Vector2(200, 200);
mousePrevious = new Vector2(-1, -1);

function SetCameraMode(_state, _following = noone, _targetPos = new Vector2(-1, -1))
{
    currentState = _state;
    FollowingObject = _following;
    if (_targetPos.x == -1 || _targetPos.y == -1) target.Set(x, y);
    else target.Set(_targetPos.x, _targetPos.y); 
}