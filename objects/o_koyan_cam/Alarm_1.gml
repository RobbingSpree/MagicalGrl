/// @desc (Full_View) - (Aftermath)
// Only Work, if (Full_View) is "NO-LONGER" Needed --------------------------------------------------------------//
global._zoom_amount(k_ZOOM_VALUE_def);	// (Before) Value's are (Now) Equal to there Changed (Global) Value's

// Rewind to Your (Usual) Setting's
k_pixel_perfection_checker();

// (Alert)
show_debug_message("|-| (" + string_upper(room_get_name(room_previous(room))) +") is over, converting ("+ string_upper(room_get_name(room)) + ") settings back to (Preferred) |-|");

// Start The Stabilize Alarm
event_perform(ev_alarm, 0);