/// @param surface
/// @param [xscale]
/// @param [yscale]
/// @param [colour]
/// @param [alpha]

var _surface = argument[0];
var _xscale = ((argument_count > 2) && (argument[2] != undefined))? argument[2] : 1;
var _yscale = ((argument_count > 3) && (argument[3] != undefined))? argument[3] : 1;
var _colour = ((argument_count > 4) && (argument[4] != undefined))? argument[4] : c_white;
var _alpha  = ((argument_count > 5) && (argument[5] != undefined))? argument[5] : 1;

if (!surface_exists(_surface)) exit;

draw_surface_ext(_surface, guido_x, guido_y, _xscale, _yscale, 0, _colour, _alpha);

guido_x += GUIDO_WIDGET_SEPARATION + _xscale*surface_get_width(_surface);
__guido_line_height = max(__guido_line_height, _yscale*surface_get_height(_surface));

guido_prev_name  = undefined;
guido_prev_state = undefined;
guido_prev_value = undefined;