/// @desc Draw a Box for "VISUAL" Info
if (_debug_ui && !_optimize) {
	var c = _db_color;

	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_alpha(1);

	// If there is a (Target) Show it's Pozition with a (Rectangle-Box) if (noone) Then just show the (Camera's) Pozition
	if (!_target_only) {var dbuffer = 96; draw_rectangle_color(x+dbuffer, y+dbuffer, x-dbuffer, y-dbuffer, c, c, c, c, true);} // If it is "NOT" an (Target_Only) Mode
	else {
		if (instance_exists(_target)) {
			var xbuffer = sprite_get_width(_target)  + 16;
			var ybuffer = sprite_get_height(_target) + 16;

			// Draw a "BOX" that will follow our (Target) object
			draw_rectangle_color(xto+xbuffer, yto+ybuffer, xto-xbuffer, yto-ybuffer, c, c, c, c, true);
		}
	}
}