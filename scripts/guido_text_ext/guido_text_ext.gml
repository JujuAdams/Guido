/// @param string
/// @param sep
/// @param w

var _string = argument0;
var _sep    = argument1;
var _w      = argument2;

draw_text_ext(guido_x, guido_y, _string, _sep, _w);

guido_x += GUIDO_ELEMENT_SEPARATION + string_width_ext(_string, _sep, _w);
__guido_line_height = max(__guido_line_height, string_height_ext(_string, _sep, _w));