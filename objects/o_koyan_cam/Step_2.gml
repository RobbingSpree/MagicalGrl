/// @desc (OffSet)
if (instance_exists(_target)) {
	var _x_previous = sign(_target.x - _target.xprevious);
	var _y_previous = sign(_target.y - _target.yprevious);
} else {
	var _x_previous = 0;
	var _y_previous = 0;
}

if (_x_previous != 0) {_x_pre_offset = _x_previous;}
if (_y_previous != 0) {_y_pre_offset = _y_previous;}

calculated_x_offset = (_x_offset * _x_pre_offset);	// "X" Offset Shortcut Local Variable
calculated_y_offset = (_y_offset * _y_pre_offset);	// "X" Offset Shortcut Local Variable