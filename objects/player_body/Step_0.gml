//JUST FOR THE DEMO
movement_scr() //not necessary for IK


///Setting the IK variables///
//these are the variables used in the draw_leg script but can be configured depending on how you move you character.

if speed>0.1
{
    legspeed=speed //in normal motion, the legspeed should be the same as the speed
}
else
{
    legspeed+=(0-legspeed)/7  //but when going slow/stopping, lerp the leg speed to 0 as this looks more realistic
    speed=0
}

movingdirection=direction //direction the leg animation will move, this should always be in the direction of movement

facingdirection=point_direction(x,y,mouse_x,mouse_y) //direction the character will face

///////////

hipy=y-(thigh+calf) //set the hip position. Note that you can move this y position to crouch for example.
hipx=x

IK_step() //run the IK system

///////////

///JUST FOR THE DEMO
bounce_scr() //not necessary for IK


