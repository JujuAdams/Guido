/// @param sprite
/// @param image
/// @param [xscale]
/// @param [yscale]
/// @param [angle]
/// @param [colour]
/// @param [alpha]

var _sprite = argument[0];
var _image  = argument[1];
var _xscale = ((argument_count > 2) && (argument[2] != undefined))? argument[2] : 1;
var _yscale = ((argument_count > 3) && (argument[3] != undefined))? argument[3] : 1;
var _angle  = ((argument_count > 4) && (argument[4] != undefined))? argument[4] : 0;
var _colour = ((argument_count > 5) && (argument[5] != undefined))? argument[5] : c_white;
var _alpha  = ((argument_count > 6) && (argument[6] != undefined))? argument[6] : 1;


//Don't draw anything if we can't find this sprite
if (!sprite_exists(_sprite)) exit;


//Draw
draw_sprite_ext(_sprite, _image, guido_x + _xscale*sprite_get_xoffset(_sprite), guido_y + _yscale*sprite_get_yoffset(_sprite), _xscale, _yscale, _angle, _colour, _alpha);


//Update draw position
guido_spacer(GUIDO_WIDGET_SEPARATION + _xscale*sprite_get_width(_sprite),
             _yscale*sprite_get_height(_sprite));


//Reset public state
guido_prev_name  = undefined;
guido_prev_state = GUIDO_STATE.NULL;
guido_prev_value = undefined;


//Return a NULL state because this element is non-interactive
return GUIDO_STATE.NULL;