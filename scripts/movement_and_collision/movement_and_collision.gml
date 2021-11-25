///@function movement_and_collision
///@arg direction
///@arg movespeed
///@arg wall object
/// returns true if blocked by a wall.
function movement_and_collision(_mv_dir, _mv_spd, _wall) {

#macro no_direction -1  //Comment or Remove this line if you already have it defined elsewhere

	///********************************************************///
	///         PLEASE REPORT ISSUES TO PIXELATED POPE         ///
	/// Twitter: @pixelated_pope  Discord: Pixelated_Pope#7777 ///
	///********************************************************///

	//Settings
	var _max_scan_angle = 75,
	    _inc = 1,
   
	    _count  = argument_count > 3 ? argument[3]+1 : 1,
	    _limit  = 4;


	if(_mv_dir == no_direction || _mv_spd == 0 || _count > _limit) return false;
 
	var _xtarg = x + lengthdir_x(_mv_spd, _mv_dir),
	    _ytarg = y + lengthdir_y(_mv_spd, _mv_dir);
 
	if(!place_meeting(_xtarg, _ytarg, _wall))
	{ //Nothing in the way, move forward
	  x = _xtarg;
	  y = _ytarg;
	  return false;
	}

	var _x_inc = lengthdir_x(1, _mv_dir),
	    _y_inc = lengthdir_y(1, _mv_dir);
 
	//Move to just inside the wall
	while(!place_meeting(_xtarg, _ytarg, _wall))
	{
	  if(point_distance(x, y, _xtarg + _x_inc, _ytarg + _y_inc) > _mv_spd) break;
	  _xtarg += _x_inc;
	  _ytarg += _y_inc;
	}
 
	//Scan for openings laterally
	var _dist = 0;

	do
	{
	  _dist += _inc;
	  var _sign = 1,
	      _test_dir = _mv_dir;
	  repeat(2)
	  {
	    var _testx = _xtarg + lengthdir_x(_dist, _mv_dir + 90 * _sign);
	    var _testy = _ytarg + lengthdir_y(_dist, _mv_dir + 90 * _sign);
	    _test_dir = point_direction(x, y, _testx, _testy);
	    if(!place_meeting(_testx, _testy, _wall)) //We found an opening.  Go ahead and move towards that.
	        return movement_and_collision(_test_dir, _mv_spd, _wall, _count);

	    _sign = -1;
	  }
	} until(abs(angle_difference(_mv_dir, _test_dir)) > _max_scan_angle)
 
	//Face plant into wall
	while(!place_meeting(x + _x_inc, y + _y_inc, _wall))
	{
	    x += _x_inc;
	    y += _y_inc;
	}
 
	return true;


}


function dpad_angle(x_axis, y_axis) {

	var angle = 0;

	if x_axis !=0 || y_axis !=0
	{
		angle = 4+2*y_axis;
		if angle == 4 && x_axis == 1
			angle = 0;
		if x_axis !=0 && y_axis !=0
			angle += x_axis*y_axis;
	}

	return floor(angle/2); 
}
