/// @desc (Optimize) Use This for Mega Project
// Use (Optimize) Mode if your project has no unchecked (Object_Existence)
// And use your (Special) persistent object's to always follow the (_target) object so they will stay remain in the region and don't get de-activated

// (DE-Activate) All of the Object's that are Outside of The "VIEW" Region
if (_target != noone && instance_exists(_target) && _optimize)
	{instance_deactivate_all(true);}