/// @param lineSeparation
/// @param maxWisth
/// @param value
/// @param [value...]

var _sep = argument[0];
var _w   = argument[1];

var _string = "";
var _i = 2;
repeat(argument_count - 2)
{
    _string += string(argument[_i]);
    ++_i;
}

draw_text_ext(guido_x, guido_y, _string, _sep, _w);

guido_x += GUIDO_WIDGET_SEPARATION + string_width_ext(_string, _sep, _w);
__guido_line_height = max(__guido_line_height, string_height_ext(_string, _sep, _w));