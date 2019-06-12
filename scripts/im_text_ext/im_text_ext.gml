/// @param string
/// @param sep
/// @param w

var _string = argument0;
var _sep    = argument1;
var _w      = argument2;

draw_text_ext(im_x, im_y, _string, _sep, _w);

im_x += IM_ELEMENT_SEPARATION + string_width_ext(_string, _sep, _w);
__im_line_height = max(__im_line_height, string_height_ext(_string, _sep, _w));