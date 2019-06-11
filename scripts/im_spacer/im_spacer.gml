/// @param [width]
/// @param [height]

var _width  = ((argument_count > 0) && is_real(argument[0]))? argument[0] : 0;
var _height = ((argument_count > 1) && is_real(argument[1]))? argument[1] : 0;

__im_pos_x += IM_ELEMENT_SEPARATION + _width;
__im_line_height = max(__im_line_height, _height);