/// @param script
/// @param sprite
/// @param centreL
/// @param centreT
/// @param centreR
/// @param centreB

var _script   = argument0;
var _sprite   = argument1;
var _centre_l = argument2;
var _centre_t = argument3;
var _centre_r = argument4;
var _centre_b = argument5;

var _array = array_create(__GUIDO_FORMAT.__SIZE);
_array[@ __GUIDO_FORMAT.SPRITE  ] = _sprite;
_array[@ __GUIDO_FORMAT.CENTRE_L] = _centre_l;
_array[@ __GUIDO_FORMAT.CENTRE_T] = _centre_t;
_array[@ __GUIDO_FORMAT.CENTRE_R] = _centre_r;
_array[@ __GUIDO_FORMAT.CENTRE_B] = _centre_b;
_array[@ __GUIDO_FORMAT.SPRITE_W] = sprite_get_width(_sprite);
_array[@ __GUIDO_FORMAT.SPRITE_H] = sprite_get_height(_sprite);

__guido_format[@ _script - __guido_format_min_script] = _array;

return _array;