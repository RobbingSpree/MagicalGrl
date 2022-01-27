//draw feet hitbox
//draw_sprite(hit_box_spr,0,x,y);

//draw the gun below if facing direction <180deg (depth ordering)
if facingdirection>180 {
	draw_sprite(hair_spr,0,hipx,hipy-20+sin(degtorad(b)));
}
//drawing the body
draw_sprite_ext(torso_spr,0,hipx,hipy+2*sin(degtorad(b))-6,1.8+abs(lengthdir_x(0.5,facingdirection+90)),3,0,skin_col,1)
var shouldy = hipy+sin(degtorad(b)+0.5)-14;
//draw shirt
var shirt_rot = 18-floor((facingdirection)/18)
//draw_sprite(shirt_spr,1,hipx,hipy+sin(degtorad(b)+0.5));
draw_sprite_part(shirt_spr,0,7+shirt_rot+debug,0,10,16,hipx-4,shouldy);

//drawing the head
draw_sprite_ext(sprite0,0,hipx+lengthdir_x(3,facingdirection),hipy+sin(degtorad(b)+0.5)-16,0.7,1,0,skin_col,1)
//draw the face 
shouldy -= 5;
draw_sprite_part(face_spr,0,8+shirt_rot,0,6,8,hipx-3,shouldy);

///drawing the IK legs
draw_leg(hipx,hipy,thigh,calf,motion_counter,4)
draw_leg(hipx,hipy,thigh,calf,motion_counter+180,-4)

//draw skirt
draw_sprite(skirt_spr,0,hipx,hipy+sin(degtorad(b)+0.5));


//draw the gun above if facing direction >=180deg (depth ordering)
if facingdirection<=180 {
	draw_sprite(hair_spr,0,hipx,hipy-20+sin(degtorad(b)));
}
