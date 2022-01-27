/// @desc Destroy The Camera
var active  = camera_get_active();
if (active == global.koyan_cam)
	{camera_destroy(global.koyan_cam);}