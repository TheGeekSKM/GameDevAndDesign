if (global.vars.pause) global.vars.ResumeGame(id);
else global.vars.PauseGame(id);

if (global.vars.pause)
{
	obj_camera.SetCameraMode(CameraMode.FollowMouseDrag);
}
else
{
	obj_camera.SetCameraMode(CameraMode.MoveToFollowTarget, id);
}