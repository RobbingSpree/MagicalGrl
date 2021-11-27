//draw the gun below if facing direction <180deg (depth ordering)
if facingdirection<180
draw_sprite_ext(sprite3,0,hipx+lengthdir_x(2,facingdirection),hipy-10,2,2,point_direction(x,y,mouse_x,mouse_y),c_white,1)

//drawing the body
draw_sprite_ext(sprite0,0,hipx,hipy+2*sin(degtorad(b))-6,1.8+abs(lengthdir_x(0.5,facingdirection+90)),3,0,c_black,1)

//drawing the head
draw_sprite_ext(sprite0,0,hipx+lengthdir_x(3,facingdirection),hipy+sin(degtorad(b)+0.5)-16,0.7,1,0,c_black,1)

///drawing the IK legs
draw_set_color(c_black)
draw_leg(hipx,hipy,thigh,calf,motion_counter,4)
draw_leg(hipx,hipy,thigh,calf,motion_counter+180,-4)
///

//draw the gun above if facing direction >=180deg (depth ordering)
if facingdirection>=180
draw_sprite_ext(sprite3,0,hipx+lengthdir_x(2,facingdirection),hipy-10,2,2,point_direction(x,y,mouse_x,mouse_y),c_white,1)



