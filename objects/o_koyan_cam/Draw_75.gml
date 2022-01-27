/// @desc (Debug_UI)
var calcX = _v_X > 0 ? (_v_X-_x_offset) : _v_X;	// Calculated (_v_X) Variable
var calcY = _v_Y > 0 ? (_v_Y-_y_offset) : _v_Y;	// Calculated (_v_Y) Variable

// If (Debug) "ACTIVE" and (Optimize) mode is "DE-ACTIVE" then draw (UI)
if (_debug_ui && !_optimize) {
	var v_p = _view_port; // (Shortcut)

	// Print "FPS"
	k_fps_specs();

	// Print "STANDARD" (Cam_Debug_UI)
	draw_set_color(_db_color);
	draw_set_halign(fa_left);
	draw_text(12, 48,
		k_cam_display_specs(k_display._app_surface)								+ "\n"		+
		k_cam_display_specs(k_display._screen)									+ "\n"		+
		k_cam_display_specs(k_display._window)									+ "\n"		+
		k_cam_display_specs(k_display._view) 									+ "\n"		+
		k_cam_display_specs(k_display._gui)										+ "\n\n"	+

		"Room_W: "		+ string(room_width)									+ "\n"		+
		"Room_H: "		+ string(room_height)									+ "\n"		+
		"Room: "		+ string(room_get_name(room))							+ "\n\n"	+

		"Room_Cam: "	+ string(room_get_camera(room, v_p))					+ "\n"		+
		"Current_Cam: "	+ string(k_cam)											+ "\n"		+
		"Default_Cam: "	+ string(camera_get_default())							+ "\n\n"	+

		"V_Port: "		+ string(room_get_viewport(room, v_p))					+ "\n"		+
		"V_Current: "	+ string(view_current)									+ "\n"		+
		"Z_Amount: "	+ string(_zoom_amount)									+ "\n\n"	+

		"Cam_X: "		+ string(calcX) + " + " + string(calculated_x_offset)	+ "\n"		+
		"Cam_Y: "		+ string(calcY)	+ " + " + string(calculated_y_offset)	+ "\n"		+
		"Cam_SPD: "		+ string(_camera_speed)									+ "\n"
	);
	draw_set_halign(fa_right);
	draw_text(global._gui_W-6, 24,
		"("				+ string(_c_mode)							+ ")\n"		+
		"Target: "		+ object_get_name(_target)					+ "\n"		+
		"Target_X: "	+ string(xto)								+ "\n"		+
		"Target_Y: "    + string(yto)								+ "\n\n"	+

		"F_Screen: "	+ string(_f_screen)							+ "\n"		+
		"P_Perfect: "	+ string(_pixel_perfect)					+ "\n"		+
		"Boundless: "	+ string(_freedom)							+ "\n"		+
		"Optimize: "	+ string(_optimize)							+ "\n"		+
		"D_UI: "		+ string(_debug_ui)							+ "\n\n"	+

		"G_Divider: "	+ string(_gui_divide)						+ "\n"		+
		"V_Multply: "	+ string(_v_multply)						+ "\n"		+
		"R_Multply: "	+ string(_r_multply)						+ "\n"		+
		"Display_AA: "	+ string(display_aa)						+ "\n"
	);
} else if (_debug_ui && _optimize) {k_fps_specs();}	// Print "FPS"

// Turn Color Back To The Original
draw_set_color(c_white);
