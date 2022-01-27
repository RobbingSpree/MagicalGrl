/// @desc (Setting's)

// Set the (Local) Function to (Global) Variable so we can use this (Outside)
global._cam_mode_change = scr_cam_change;
global._screen_shake	= scr_screen_shake;
global._zoom_amount		= scr_zooming;
global._cam_speed		= scr_speed;

// Camera Pozition's (Update)
k_cam = view_get_camera(global.koyan_cam);
_v_X  = camera_get_view_x(global.koyan_cam);					// "CAMERA" (Updated-X)
_v_Y  = camera_get_view_y(global.koyan_cam);					// "CAMERA" (Updated-Y)

// (Screen_Shake) Setting's
_v_X		 += random_range(-_shake_Remain, _shake_Remain);
_v_Y		 += random_range(-_shake_Remain, _shake_Remain);
_shake_Remain = max(0, _shake_Remain - ((1 / _shake_Length) * _shake_Magnitude));

// "FORCE" Room's to Use Our Camera || For "ALL" (Room's) ViewPort, etc ----(VERY_VERY_Important)----//
if (room_get_camera(room, _view_port) != k_cam) {
	view_set_camera(_view_port, global.koyan_cam);
	room_set_viewport(room, _view_port, true, 0, 0, _port_width, _port_height);
	room_set_camera(room, _view_port, global.koyan_cam);

	if (!view_enabled)				   {view_enabled = true;}									// (Force) "VIEW" to be (Active)
	if (!view_get_visible(_view_port)) {view_set_visible(_view_port, true);}					// (Force) "VIEW" to be (Visible)

	show_debug_message("|-| Forced '" + string(room_get_name(room)) + "' and 'K-CAM' Connection |-|");
}

// Add Camera (Mode's) -----------------------(Very_Important)--------------------------//
#region (Special) Cam Mode's
	// (Dont Touch) || Zoom Value's
	if (_zoom_amount != 0 && _zoom_amount != -1 && _zoom_amount != 1) {var zoom = _zoom_amount;} 
	else															  {var zoom = 1;}

	// (Can Change) || Bigger (Faster) / Smaller (Slower)
	if (_camera_speed > 1)	{var _sp = speed_rate + (speed_multply * _camera_speed);} 
	else					{var _sp = speed_rate;}

	// Camera (Mod) Changing System
	switch (global._cam_mode) {																 // Updated should be checked not the original one (_c_mode) for be able to go back to the original (_c_mode)
		// Main mode, it follow's the object center if there is any
		case "FOLLOW_TARGET":
			if (_target != noone && instance_exists(_target)) {
				xto  = (_target.x); yto = (_target.y);										 // If there is a (Target) Follow, "TARGET_X" and "TARGET_Y"

				_v_X = (xto + calculated_x_offset) - (_v_W_Half * zoom);					 // Follow "X_SPEED"
				_v_Y = (yto + calculated_y_offset) - (_v_H_Half * zoom);					 // Follow "Y_SPEED"

				_target_only = true;														 // (Target_Only)
			} else {break;}																	
		break;																				

		// Just Follow the Mouse Cursor														
		case "FOLLOW_MOUSE":
			xto = (mouse_x); yto = (mouse_y);												 // Follow "MOUSE_X" and "MOUSE_Y"

			_v_X = (xto - (_v_W_Half * zoom));												 // Follow "X_SPEED"
			_v_Y = (yto - (_v_H_Half * zoom));												 // Follow "Y_SPEED"

			_target_only = false;															 // "NOT" (Target_Only)
		break;

		// This is a mode in the other game's such as like "ENTER THE GUNGEON" etc... this allow's us to look little bit more beyond the view but not so much that it is out of the player
		case "FOLLOW_MOUSE_PEEK":
			if (_target != noone && instance_exists(_target)) {
				xto  = (mouse_x); yto = (mouse_y);											 // Follow "MOUSE_X" and "MOUSE_Y"
																							 
				_v_X = lerp(_target.x, xto + calculated_x_offset, _sp) - (_v_W_Half * zoom); // Follow "X_SPEED" With (Lerp)
				_v_Y = lerp(_target.y, yto + calculated_y_offset, _sp) - (_v_H_Half * zoom); // Follow "Y_SPEED" With (Lerp)
																							 
				_target_only = true;														 // (Target_Only)
			} else {break;}
		break;

		// This mode is just like in the (Strategy) game's you can just click the mouse and drag it across in the room
		case "FOLLOW_MOUSE_DRAG":
			var mouse_xx = display_mouse_get_x();
			var mouse_yy = display_mouse_get_y();

			if (mouse_check_button(mb_left)) {												 // (Can Change)
				_v_X += (_mouse_X_pre - mouse_xx) * _sp;
				_v_Y += (_mouse_Y_pre - mouse_yy) * _sp;
			}

			_mouse_X_pre = mouse_xx;
			_mouse_Y_pre = mouse_yy;

			_target_only = false;															 // "NOT" (Target_Only)
		break;

		// Move "VIEW" to the Mouse's (Pozition) When you collide with the Border of the "ROOM_VIEW"
		case "FOLLOW_MOUSE_BORDER":
			if (!point_in_rectangle(mouse_x, mouse_y, _v_X + (_v_W_Edit*0.1), _v_Y + (_v_H_Edit*0.1), _v_X + (_v_W_Edit*0.9), _v_Y + (_v_H_Edit*0.9))) {
				xto     = (mouse_x); yto = (mouse_y);										 // Follow "MOUSE_X" and "MOUSE_Y"

				_v_X = lerp(_v_X, (xto - (_v_W_Half * zoom)), _sp);							 // Follow "X_SPEED" With (Lerp)
				_v_Y = lerp(_v_Y, (yto - (_v_H_Half * zoom)), _sp);							 // Follow "Y_SPEED" With (Lerp)

				_target_only = false;														 // "NOT" (Target_Only)
			} else {break;}
		break;

		// "DELAYED" Camera Movement (Cinematic_Angle)
		case "SMOOTH_TO_TARGET":
			if (_target != noone && instance_exists(_target)) {
				xto	= (_target.x); yto = (_target.y);												// If there is a (Target) Follow "X" and Follow "Y"

				_v_X = lerp(_v_X, ((xto + calculated_x_offset) - (_v_W_Half * zoom)), _sp);			// Follow "X_SPEED" With (Lerp)
				_v_Y = lerp(_v_Y, ((yto + calculated_y_offset) - (_v_H_Half * zoom)), _sp);			// Follow "Y_SPEED" With (Lerp)

				_target_only = true;																// (Target_Only)
			} else {break;}
		break;

		// Go to (Clicked) "MOUSE_X" and "MOUSE_Y" Pozition's
		case "MOVE_TO_CLICK":
			if (mouse_check_button_pressed(mb_left)) {
				xto = (mouse_x); yto = (mouse_y);											// Follow (Clicked) "MOUSE_X" and "MOUSE_Y" Pozition 
				x   = xto;																	// Camera (Sprite) Follow "X_TO"
				y   = yto;																	// Camera (Sprite) Follow "Y_TO"

				_v_X = (x - (_v_W_Half * zoom));											// Follow (Object's) "X"
				_v_Y = (y - (_v_H_Half * zoom));											// Follow (Object's) "Y"

				_target_only = false;														// "NOT" (Target_Only)
			} else {break;}
		break;

		// Go to The (Target) "X" and "Y" Pozition's with (Lerp) Function and Change The Camera (Mode)
		case "MOVE_TO_TARGET":
			if (_target != noone && instance_exists(_target)) {
				xto     = (_target.x); yto = (_target.y);									// If there is a (Target) Follow "X" and Follow "Y"

				_v_X = lerp(_v_X, (xto - (_v_W_Half * zoom)), _sp);							// Follow "X_SPEED" With (Lerp)
				_v_Y = lerp(_v_Y, (yto - (_v_H_Half * zoom)), _sp);							// Follow "Y_SPEED" With (Lerp)

				// Changed the (Mode) Automatically because we are so close to the "TARGET" Object because of (Lerp)
				if (point_distance(x, y, (xto - _v_W_Half), (yto - _v_H_Half)) < 1)
					{global._cam_mode = _c_mode;}											// (Can Change)

				_target_only = true;														// (Target_Only)
			} else {break;}
		break;
		
		// "DELAYED" Camera Movement with Bounds just like in the game Celeste for (Cinematic_Angle)
		case "CELESTE_MODE":
		    if (_target != noone && instance_exists(_target)) {
		        xto    = (_target.x);
		        yto    = (_target.y);
    
		        // Check Bound Objects Sprite Collision Boxes
				var bound_object = noone;
		        var CollidedBound  = instance_position(_target.x, _target.y, bound_object);
		        if (CollidedBound != noone) {
					xto = clamp(xto, CollidedBound.bbox_left + (_v_W_Half * zoom), CollidedBound.bbox_right  - (_v_W_Half * zoom));
					yto = clamp(yto, CollidedBound.bbox_top  + (_v_H_Half * zoom), CollidedBound.bbox_bottom - (_v_H_Half * zoom));
		        }

		        _v_X = lerp(_v_X, ((xto + calculated_x_offset) - (_v_W_Half * zoom)), _sp);
		        _v_Y = lerp(_v_Y, ((yto + calculated_y_offset) - (_v_H_Half * zoom)), _sp);

		        _target_only = true;
		    } else {break;}
		 break;
	}
#endregion

// If There is a "BLACK_BAR" Issue Make It More Obvious To The (Admin) || Camera (Debug_UI) Panel "VISIBLITY" (On-Off)
if (_debug_ui) {visible = true;  window_set_color(c_red);}
else		   {visible = false; window_set_color(c_black);}

// (Region RE-Activate System) For "OPTIMIZATION" -----------(Very_Important)-----------//
// If (Optimize) "ON" then object's that go (Inside) of "VIEW" region get's "ACTIVATED"
if (_optimize) {
	instance_activate_region(_v_X, _v_Y, _v_W_Edit, _v_H_Edit, true);

	instance_activate_object(o_koyan_cam);						// (Don't Touch-Guarantee)
	instance_activate_object(_target);							// (Don't Touch-Guarantee)

	instance_activate_layer("Instances");						// (Can Change) || (Can Add More) || Special (Layer's) you dont want to close while in "OPTIMIZE" Mode like "PERSISTENT" object's (Layer)
	//instance_activate_layer("Instances_2");					// (Like this)
	//instance_activate_layer("Instances_3");					// (And Like this)

	if (alarm[2] == -1) {alarm[2] = _delay;}					// (Loop) || (Can_Change)
}

// (Zooming) Lerp the variables and Setting's --------------------------//
// If it's "ABOVE" or "BELOW" (-1 / 0 / 1) value's then Work because, Multplying with either of these will only give the same value's... duh
if (_zoom_target != 0 && _zoom_target != 1 && _zoom_target != -1) {
	var rate   = speed_rate + (speed_multply * _camera_speed);			// These value's can be changed in the "CREATE" event
	var _viewW = camera_get_view_width(global.koyan_cam);
	var _viewH = camera_get_view_height(global.koyan_cam);

	_zoom_amount = abs(lerp(_zoom_amount, _zoom_target, rate));

	var new_w = lerp(_viewW, (_zoom_amount * _v_W_Edit), rate);
	var new_h = lerp(_viewH, (_zoom_amount * _v_H_Edit), rate);

	//_v_X -=  (new_w - _viewW);											// New "X" Pozition of the Camera
	//_v_Y -=  (new_h - _viewH);											// New "Y" Pozition of the Camera

	camera_set_view_size(global.koyan_cam, new_w, new_h);				// Set these "SIZE" value's to our camera
}

// (Boundless) Clamp (Variable's) and (Setting's) ----------------------------------------------//
if (!_freedom) {
	// (Keep) The Camera "CENTER" Inside the Room With Using "BUFF"
	_v_X = clamp(_v_X, 0, (room_width  - _v_W_Edit));											// (Can Change) || "X" (Buff)
	_v_Y = clamp(_v_Y, 0, (room_height - _v_H_Edit));											// (Can Change) || "Y" (Buff)

	// (Lock) The Preffered Values to The Tested (View) and (Resolution) Values
	_max_res			= floor(abs((_display_W / _ideal_W) * (_display_H / _ideal_H)));		// (Don't Touch) || (Resolution) Restriction
	global._v_multply   = clamp(global._v_multply,   0.10, 8);									// (Don't Touch) || "VIEW" (Multiply)
	global._res_multply = clamp(global._res_multply,    1, _max_res);							// (Can Change)  || "RESOLUTION" Cannot go beyond his best condition for the (Monitor)
	global._gui_divider = clamp(global._gui_divider, 0.10, 6);									// (Can Change)  || "GUI"		 Cannot go beyond his best condition for the (Viewer)
} else {_pixel_perfect  = false;}																// (Don't Touch) || (De-Activate) Forced (Pixel-Perfection) if we are in "BOUNDLESS" Mode !!

// (Supported_Resolutions) If players monitor is too unique for its own good this camera will force your preferred settings to be compatiple with that hardware so its visualy not get broken
if (_supported_res != noone && access) {
	for (var i = 0; i < array_length(_supported_res); i++) {
		if (_display_W == _supported_res[i, 0] && _display_H == _supported_res[i, 1]) 
			{event_perform(ev_alarm, 0);}	// Kinda "LOOPING" The Alarm here, so "SURFACE" overwriting dont make (Memory_Leaks)
	}
}

// If there is a (Special-Room) picked that (Room's) "WIDTH" and "HEIGHT" changes Camera's (View) Value's With Its Own ----(VERY_Important)----//
if (_full_v_of_room != noone) {
	for (var i = 0; i < array_length(_full_v_of_room); i++) {
		if (room_exists(_full_v_of_room[i]) && room == _full_v_of_room[i]) {	// If "ROOMS" Exists and if we are in one of those "ROOMS" Work
			_v_W_Edit = room_width;												// (Dont Touch) || Camera (Width)	|| This is a (Crucial) "VALUE" for The (Systems)
			_v_H_Edit = room_height;											// (Dont Touch) || Camera (Height)	|| This is a (Crucial) "VALUE" for The (Systems)
			alarm[1]  = _delay;													// (Can Change) || For (Standard-Rooms) Setup an Alarm that will convert these to (Prefered) Setting's

			global._zoom_amount(0);												// (Dont Touch) || (Full-View) Should not be (Zoomed)

			// For Starting Stabilize Alarm || (Dont Touch)
			if (room_access) 
				{room_access = false; event_perform(ev_alarm, 0);}
		}
	}
}

// If These Variable's are "CHANGED" in (Anyway) or (Anywhere) Only Then Start the (Stabilizing-Alarm) ---------(VERY_VERY_Important)----------//
if (pass && (global._current_target == _target && global._res_multply == _r_multply && global._gui_divider == _gui_divide && global._fullscreen == _f_screen))
	{alarm[0] = _delay;}

// (Update) The Global's for accessing from another objects || So they can just use (Global) variable's rather than (Local) ones by using (With) and such
global._cam_X = _v_X;
global._cam_Y = _v_Y;
global._cam_W = _v_W_Edit;
global._cam_H = _v_H_Edit;

// Camera's "POZITION" Setting's (Update) -----(Very_Important)-----// This (Should) be Always The "LAST" Setup and in should be in a (Loop)
camera_set_view_pos(global.koyan_cam, _v_X, _v_Y);					// Camera's (X / Y) Pozition