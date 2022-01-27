/// @description Insert description here
// You can write your code in this editor
image_speed = 0;

facing = 0;
mv_spd = 3;
dpad_dir=no_direction; //vert2 of player input
facingdirection = 0; //character facing direction used in animation
pstate = state.idle; //player's current state in state machine
form = f.base; //player's current form as magic grl
combat = false; //flag for if combat actions are prioritized

global.last_room = Room1;

//stats
adroit = 1;
charm = 1;
gumption = 1;
attunement = 1;
empathy = 1;

height = 0;
vault_height = 96; 