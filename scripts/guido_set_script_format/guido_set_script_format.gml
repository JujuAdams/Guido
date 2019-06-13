/// Different sprite images are used depending on the state of the widget:
/// GUIDO_STATE.NULL     = image 0:
/// GUIDO_STATE.OVER     = image 1:
/// GUIDO_STATE.PRESSED  = image 2:
/// GUIDO_STATE.DOWN     = image 3:
/// GUIDO_STATE.RELEASED = image 4:
/// 
/// Some widgets retain focus or can be toggled e.g. guido_radio() or guido_real_field()
//  When a widget has focus or is toggled on, it'll use image 4 (GUIDO_STATE.RELEASED).
///
/// @param script
/// @param sprite
/// @param [centreL]
/// @param [centreT]
/// @param [centreR]
/// @param [centreB]

var _script   = argument[0];
var _sprite   = argument[1];
var _centre_l = (argument_count > 2)? argument[2] : 0;
var _centre_t = (argument_count > 3)? argument[3] : 0;
var _centre_r = (argument_count > 4)? argument[4] : 0;
var _centre_b = (argument_count > 5)? argument[5] : 0;

if (is_string(_script)) _script = asset_get_index(_script);

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