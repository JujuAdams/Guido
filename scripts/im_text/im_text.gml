/// @param string

var _string = argument0;

draw_text(__im_pos_x, __im_pos_y, _string);

__im_pos_x += __im_sep_x + string_width(_string);
__im_line_height = max(__im_line_height, string_height(_string));