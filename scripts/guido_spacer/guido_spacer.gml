/// @param [width]
/// @param [height]

var _width  = ((argument_count > 0) && is_real(argument[0]))? argument[0] : GUIDO_WIDGET_SEPARATION;
var _height = ((argument_count > 1) && is_real(argument[1]))? argument[1] : 0;

guido_x += _width;
guido_line_height = max(guido_line_height, _height);